import 'package:flutter_test/flutter_test.dart';
import 'package:sah/data/models/user.dart';

void main() {
  group('User', () {
    test('toJson/fromJson round-trip preserva todos os campos', () {
      final original = User(
        id: 'u_1',
        nome: 'Lucas',
        email: 'lucas@sah.app',
        isAdmin: true,
        isOwner: false,
        isBlocked: false,
        createdAt: DateTime.utc(2026, 1, 15, 10, 30),
      );

      final round = User.fromJson(original.toJson());

      expect(round.id, 'u_1');
      expect(round.nome, 'Lucas');
      expect(round.email, 'lucas@sah.app');
      expect(round.isAdmin, true);
      expect(round.isOwner, false);
      expect(round.isBlocked, false);
      expect(round.createdAt, DateTime.utc(2026, 1, 15, 10, 30));
    });

    test('fromJson sem flags usa defaults false', () {
      final json = {
        'id': 'u_2',
        'nome': 'Maria',
        'email': 'maria@sah.app',
        'created_at': '2026-01-01T00:00:00.000Z',
      };

      final user = User.fromJson(json);
      expect(user.isAdmin, false);
      expect(user.isOwner, false);
      expect(user.isBlocked, false);
    });
  });
}
