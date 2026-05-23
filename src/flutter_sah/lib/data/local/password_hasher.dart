import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PasswordHasher {
  static String hash(String password) {
    final salt = _generateSalt();
    final digest = sha256.convert(utf8.encode('$salt$password'));
    return '$salt\$${digest.toString()}';
  }

  static bool verify(String password, String stored) {
    final parts = stored.split(r'$');
    if (parts.length != 2) return false;
    final salt = parts[0];
    final expectedHash = parts[1];
    final digest = sha256.convert(utf8.encode('$salt$password'));
    return digest.toString() == expectedHash;
  }

  static String _generateSalt() {
    final rng = Random.secure();
    final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
