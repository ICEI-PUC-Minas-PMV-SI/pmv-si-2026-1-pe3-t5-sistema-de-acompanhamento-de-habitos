import 'dart:convert';
import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';

class PasswordHasher {
  /// Cost factor do bcrypt. 10 é o default da maioria das libs e leva ~80ms
  /// no hash. Não subir pra mais que 12 em mobile (perceptível).
  static const _bcryptCost = 10;

  /// Hash nova: sempre bcrypt.
  static String hash(String password) =>
      BCrypt.hashpw(password, BCrypt.gensalt(logRounds: _bcryptCost));

  /// Verify auto-detecta o formato.
  /// - bcrypt: começa com `$2a$`, `$2b$` ou `$2y$`
  /// - legacy SHA-256: `<salt>$<hex>` (sem prefixo `$2`)
  static bool verify(String password, String stored) {
    if (stored.startsWith(r'$2')) {
      try {
        return BCrypt.checkpw(password, stored);
      } catch (_) {
        return false;
      }
    }
    return _verifyLegacy(password, stored);
  }

  /// True se o hash armazenado está em formato legado (SHA-256) e deveria
  /// ser migrado para bcrypt no próximo login bem-sucedido.
  static bool needsRehash(String stored) => !stored.startsWith(r'$2');

  static bool _verifyLegacy(String password, String stored) {
    final parts = stored.split(r'$');
    if (parts.length != 2) return false;
    final salt = parts[0];
    final expectedHash = parts[1];
    final digest = sha256.convert(utf8.encode('$salt$password'));
    return digest.toString() == expectedHash;
  }
}
