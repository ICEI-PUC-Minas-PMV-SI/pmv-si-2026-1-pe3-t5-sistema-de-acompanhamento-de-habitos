import 'package:flutter_test/flutter_test.dart';
import 'package:sah/data/models/execution_log.dart';
import 'package:sah/features/user_home/habits/utils/streak_calculator.dart';

ExecutionLog _log(DateTime dt, {bool frozen = false}) =>
    ExecutionLog(
      id: 'el_${dt.millisecondsSinceEpoch}',
      habitId: 'h_1',
      dataHora: dt,
      frozen: frozen,
    );

void main() {
  group('calculateStreak', () {
    final today = DateTime(2026, 5, 22);

    test('retorna 0 sem logs', () {
      expect(calculateStreak([], today), 0);
    });

    test('conta hoje + ontem + anteontem consecutivos = 3', () {
      final logs = [
        _log(DateTime(2026, 5, 22, 10)),
        _log(DateTime(2026, 5, 21, 9)),
        _log(DateTime(2026, 5, 20, 8)),
      ];
      expect(calculateStreak(logs, today), 3);
    });

    test('gap quebra a sequência — só conta o trecho que toca hoje/ontem', () {
      final logs = [
        _log(DateTime(2026, 5, 22, 10)), // hoje
        _log(DateTime(2026, 5, 21, 9)),  // ontem
        // 20/5 ausente
        _log(DateTime(2026, 5, 19, 8)),  // anteanteontem (não conta)
      ];
      expect(calculateStreak(logs, today), 2);
    });

    test('freeze no meio preserva sequência mas não soma streak', () {
      final logs = [
        _log(DateTime(2026, 5, 22, 10)),                     // hoje feito
        _log(DateTime(2026, 5, 21, 9), frozen: true),        // ontem pulado
        _log(DateTime(2026, 5, 20, 8)),                      // anteontem feito
      ];
      // streak conta apenas dias com `done`: hoje + anteontem = 2
      expect(calculateStreak(logs, today), 2);
    });

    test('freeze hoje mantém sequência de ontem', () {
      final logs = [
        _log(DateTime(2026, 5, 22, 10), frozen: true),  // hoje pulado
        _log(DateTime(2026, 5, 21, 9)),                 // ontem feito
        _log(DateTime(2026, 5, 20, 8)),                 // anteontem feito
      ];
      // cursor começa em hoje (covered por freeze), avança pra ontem (done +1),
      // anteontem (done +1) = 2
      expect(calculateStreak(logs, today), 2);
    });
  });
}
