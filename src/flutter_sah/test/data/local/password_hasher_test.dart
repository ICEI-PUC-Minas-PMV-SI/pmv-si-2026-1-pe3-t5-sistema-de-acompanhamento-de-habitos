import 'package:flutter_test/flutter_test.dart';
import 'package:sah/data/local/password_hasher.dart';

void main() {
  group('PasswordHasher', () {
    test('hash não retorna a senha em texto plano', () {
      final hashed = PasswordHasher.hash('minhasenha123');
      expect(hashed.contains('minhasenha123'), false);
      expect(hashed, isNotEmpty);
    });

    test('verify aceita a senha correta', () {
      final hashed = PasswordHasher.hash('correta');
      expect(PasswordHasher.verify('correta', hashed), true);
    });

    test('verify rejeita senha errada', () {
      final hashed = PasswordHasher.hash('correta');
      expect(PasswordHasher.verify('errada', hashed), false);
    });

    test('hashes distintos para mesma senha (salt aleatório)', () {
      final h1 = PasswordHasher.hash('mesmasenha');
      final h2 = PasswordHasher.hash('mesmasenha');
      expect(h1, isNot(h2));
      // Ambos verificam corretamente
      expect(PasswordHasher.verify('mesmasenha', h1), true);
      expect(PasswordHasher.verify('mesmasenha', h2), true);
    });
  });
}
