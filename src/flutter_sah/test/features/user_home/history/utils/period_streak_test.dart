import 'package:flutter_test/flutter_test.dart';
import 'package:sah/features/user_home/history/utils/period_streak.dart';

void main() {
  group('bestStreakInPeriod', () {
    test('retorna 0 quando não há nenhum log', () {
      final result = bestStreakInPeriod(
        daysWithLog: {},
        frequencia: {1, 2, 3, 4, 5}, // seg-sex
        from: DateTime(2026, 5, 1),
        to: DateTime(2026, 5, 7),
      );
      expect(result, 0);
    });

    test('conta streak quando todos os dias agendados têm log', () {
      // 4-8 maio 2026 (seg a sex)
      final days = {
        DateTime(2026, 5, 4), // seg
        DateTime(2026, 5, 5), // ter
        DateTime(2026, 5, 6), // qua
        DateTime(2026, 5, 7), // qui
        DateTime(2026, 5, 8), // sex
      };
      final result = bestStreakInPeriod(
        daysWithLog: days,
        frequencia: {1, 2, 3, 4, 5},
        from: DateTime(2026, 5, 4),
        to: DateTime(2026, 5, 8),
      );
      expect(result, 5);
    });

    test('gap em dia agendado quebra o streak', () {
      // Faltou 6/maio (quarta)
      final days = {
        DateTime(2026, 5, 4),
        DateTime(2026, 5, 5),
        // 5/6 ausente
        DateTime(2026, 5, 7),
        DateTime(2026, 5, 8),
      };
      final result = bestStreakInPeriod(
        daysWithLog: days,
        frequencia: {1, 2, 3, 4, 5},
        from: DateTime(2026, 5, 4),
        to: DateTime(2026, 5, 8),
      );
      // melhor streak é o segundo bloco: qui + sex = 2
      expect(result, 2);
    });

    test('dia não agendado não quebra o streak', () {
      // Frequência só seg-sex; sábado/domingo são "off" e mantêm streak
      // 4/5 (seg), 5/5 (ter), [6/5 não agendado - mas é qua, frequencia inclui]
      // vou usar frequencia seg/qua/sex
      final days = {
        DateTime(2026, 5, 4), // seg
        DateTime(2026, 5, 6), // qua
        DateTime(2026, 5, 8), // sex
      };
      final result = bestStreakInPeriod(
        daysWithLog: days,
        frequencia: {1, 3, 5}, // seg, qua, sex
        from: DateTime(2026, 5, 4),
        to: DateTime(2026, 5, 8),
      );
      // ter/qui não agendados — não quebram. Streak = 3.
      expect(result, 3);
    });
  });
}
