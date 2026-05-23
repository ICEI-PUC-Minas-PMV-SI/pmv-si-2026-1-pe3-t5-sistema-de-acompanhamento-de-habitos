import '../../../../data/models/execution_log.dart';

/// Conta os dias consecutivos de execução terminando em [today] ou [today - 1d].
/// Retorna 0 se o hábito não foi feito ontem nem hoje.
int calculateStreak(List<ExecutionLog> logs, DateTime today) {
  if (logs.isEmpty) return 0;

  final done = logs
      .map((l) => DateTime(l.dataHora.year, l.dataHora.month, l.dataHora.day))
      .toSet();

  final todayNorm = DateTime(today.year, today.month, today.day);
  final yesterdayNorm = todayNorm.subtract(const Duration(days: 1));

  // A sequência só conta se inclui hoje ou ontem (senão já quebrou)
  var cursor = done.contains(todayNorm) ? todayNorm : yesterdayNorm;
  if (!done.contains(cursor)) return 0;

  var streak = 0;
  while (done.contains(cursor)) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
}
