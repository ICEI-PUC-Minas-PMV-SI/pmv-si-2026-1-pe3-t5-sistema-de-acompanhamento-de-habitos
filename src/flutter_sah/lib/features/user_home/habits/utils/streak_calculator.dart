import '../../../../data/models/execution_log.dart';

/// Conta os dias consecutivos de execução terminando em [today] ou [today - 1d].
/// Retorna 0 se o hábito não foi feito ontem nem hoje.
///
/// Logs com `frozen=true` ("pulei o dia de propósito") mantêm a sequência
/// (cursor avança) mas não contam como +1 no streak.
int calculateStreak(List<ExecutionLog> logs, DateTime today) {
  if (logs.isEmpty) return 0;

  final done = <DateTime>{};
  final frozen = <DateTime>{};
  for (final l in logs) {
    final day = DateTime(l.dataHora.year, l.dataHora.month, l.dataHora.day);
    if (l.frozen) {
      frozen.add(day);
    } else {
      done.add(day);
    }
  }

  final todayNorm = DateTime(today.year, today.month, today.day);
  final yesterdayNorm = todayNorm.subtract(const Duration(days: 1));

  // A sequência só conta se inclui hoje ou ontem (com freeze contando como
  // "passou pelo dia" sem somar)
  bool isCovered(DateTime d) => done.contains(d) || frozen.contains(d);

  DateTime cursor;
  if (isCovered(todayNorm)) {
    cursor = todayNorm;
  } else if (isCovered(yesterdayNorm)) {
    cursor = yesterdayNorm;
  } else {
    return 0;
  }

  var streak = 0;
  while (isCovered(cursor)) {
    if (done.contains(cursor)) streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
}
