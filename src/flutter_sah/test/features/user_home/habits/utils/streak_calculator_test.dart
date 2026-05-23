import 'package:flutter_test/flutter_test.dart';
import 'package:sah/data/models/execution_log.dart';
import 'package:sah/features/user_home/habits/utils/streak_calculator.dart';

ExecutionLog _log(DateTime dt) =>
    ExecutionLog(id: 'el_${dt.millisecondsSinceEpoch}', habitId: 'h_1', dataHora: dt);

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
  });
}
