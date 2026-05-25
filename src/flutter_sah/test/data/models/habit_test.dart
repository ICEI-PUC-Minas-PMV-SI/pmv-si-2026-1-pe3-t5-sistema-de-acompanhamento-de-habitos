import 'package:flutter_test/flutter_test.dart';
import 'package:sah/data/models/habit.dart';

void main() {
  group('Habit', () {
    test('toJson/fromJson round-trip preserva todos os campos', () {
      const original = Habit(
        id: 'h_1',
        userId: 'u_1',
        nome: 'Meditar',
        descricao: 'Por 10 min',
        frequencia: [1, 3, 5],
        categoriaId: 'c_1',
        ativo: true,
        arquivado: false,
        lembretes: ['08:00', '20:30'],
      );

      final round = Habit.fromJson(original.toJson());

      expect(round.id, 'h_1');
      expect(round.userId, 'u_1');
      expect(round.nome, 'Meditar');
      expect(round.descricao, 'Por 10 min');
      expect(round.frequencia, [1, 3, 5]);
      expect(round.categoriaId, 'c_1');
      expect(round.ativo, true);
      expect(round.arquivado, false);
      expect(round.lembretes, ['08:00', '20:30']);
    });

    test('fromJson sem chave "lembretes" usa default vazio (backward compat)', () {
      final json = {
        'id': 'h_legacy',
        'user_id': 'u_1',
        'nome': 'Hábito antigo',
        'descricao': '',
        'frequencia': [1, 2, 3, 4, 5],
        'categoria_id': null,
        'ativo': true,
        'arquivado': false,
        // sem 'lembretes'
      };

      final habit = Habit.fromJson(json);
      expect(habit.lembretes, isEmpty);
    });

    test('copyWith preserva campos não alterados', () {
      const original = Habit(
        id: 'h_1',
        userId: 'u_1',
        nome: 'Ler',
        lembretes: ['09:00'],
      );

      final copy = original.copyWith(nome: 'Ler mais');

      expect(copy.id, 'h_1');
      expect(copy.userId, 'u_1');
      expect(copy.nome, 'Ler mais');
      expect(copy.lembretes, ['09:00']);
    });
  });
}
