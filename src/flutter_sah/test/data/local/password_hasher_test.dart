import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sah/data/local/password_hasher.dart';

String _legacySha256(String password) {
  final rng = Random.secure();
  final saltBytes = List<int>.generate(16, (_) => rng.nextInt(256));
  final salt = saltBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  final digest = sha256.convert(utf8.encode('$salt$password'));
  return '$salt\$${digest.toString()}';
}

void main() {
  group('PasswordHasher (bcrypt)', () {
    test('hash não retorna a senha em texto plano', () {
      final hashed = PasswordHasher.hash('minhasenha123');
      expect(hashed.contains('minhasenha123'), false);
      expect(hashed, isNotEmpty);
      expect(hashed.startsWith(r'$2'), true,
          reason: r'novo hash deve ser bcrypt ($2a/$2b/$2y...)');
    });

    test('verify aceita a senha correta', () {
      final hashed = PasswordHasher.hash('correta');
      expect(PasswordHasher.verify('correta', hashed), true);
    });

    test('verify rejeita senha errada', () {
      final hashed = PasswordHasher.hash('correta');
      expect(PasswordHasher.verify('errada', hashed), false);
    });

    test('hashes distintos para mesma senha (salt aleatório do bcrypt)', () {
      final h1 = PasswordHasher.hash('mesmasenha');
      final h2 = PasswordHasher.hash('mesmasenha');
      expect(h1, isNot(h2));
      expect(PasswordHasher.verify('mesmasenha', h1), true);
      expect(PasswordHasher.verify('mesmasenha', h2), true);
    });
  });

  group('PasswordHasher backward-compat (SHA-256 legado)', () {
    test('verify aceita hash legado válido', () {
      final legacyHash = _legacySha256('antiga');
      expect(PasswordHasher.verify('antiga', legacyHash), true);
    });

    test('verify rejeita senha errada contra hash legado', () {
      final legacyHash = _legacySha256('antiga');
      expect(PasswordHasher.verify('outra', legacyHash), false);
    });

    test('needsRehash retorna true para hash legado', () {
      final legacyHash = _legacySha256('algo');
      expect(PasswordHasher.needsRehash(legacyHash), true);
    });

    test('needsRehash retorna false para bcrypt', () {
      final bcryptHash = PasswordHasher.hash('algo');
      expect(PasswordHasher.needsRehash(bcryptHash), false);
    });
  });
}
