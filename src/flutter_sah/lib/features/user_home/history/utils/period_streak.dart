import 'dart:math';

// Retorna o maior streak de dias consecutivos cumpridos no período.
// Considera apenas dias agendados (frequencia); dias não agendados não quebram o streak.
int bestStreakInPeriod({
  required Set<DateTime> daysWithLog,
  required Set<int> frequencia,
  required DateTime from,
  required DateTime to,
}) {
  int best = 0;
  int current = 0;

  var day = DateTime(from.year, from.month, from.day);
  final lastDay = DateTime(to.year, to.month, to.day);

  while (!day.isAfter(lastDay)) {
    final dow = day.weekday % 7; // 0=dom..6=sab
    if (frequencia.contains(dow)) {
      final dayKey = DateTime(day.year, day.month, day.day);
      if (daysWithLog.contains(dayKey)) {
        current++;
        best = max(best, current);
      } else {
        current = 0;
      }
    }
    day = day.add(const Duration(days: 1));
  }

  return best;
}
