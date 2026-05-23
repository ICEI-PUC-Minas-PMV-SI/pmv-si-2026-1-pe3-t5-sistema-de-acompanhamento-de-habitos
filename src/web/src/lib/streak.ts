import type { Habit, CheckIn } from '@/features/habits/types';
import { toDateKey, fromDateKey, addDays, startOfWeek } from './date';

export function computeStreak(habit: Habit, allCheckIns: CheckIn[], todayKey: string): number {
  const checks = allCheckIns.filter((c) => c.habitId === habit.id);
  const set = new Set(checks.map((c) => c.date));
  if (set.size === 0) return 0;

  if (habit.frequency.kind === 'daily') {
    let streak = 0;
    let cursor = todayKey;
    // se hoje não bateu, começamos por ontem
    if (!set.has(cursor)) {
      cursor = toDateKey(addDays(fromDateKey(cursor), -1));
    }
    while (set.has(cursor)) {
      streak += 1;
      cursor = toDateKey(addDays(fromDateKey(cursor), -1));
    }
    return streak;
  }

  if (habit.frequency.kind === 'weekdays') {
    const days = new Set(habit.frequency.days);
    let streak = 0;
    let cursor = fromDateKey(todayKey);
    // anda para trás dia a dia, contando apenas dias agendados
    // quando achar dia agendado SEM check-in, quebra
    // limite de segurança: 2 anos
    for (let i = 0; i < 730; i++) {
      const key = toDateKey(cursor);
      if (days.has(cursor.getDay())) {
        if (set.has(key)) {
          streak += 1;
        } else if (key === todayKey) {
          // hoje agendado mas sem check-in: tolera, segue para trás
        } else {
          break;
        }
      }
      cursor = addDays(cursor, -1);
    }
    return streak;
  }

  // times-per-week
  const target = habit.frequency.count;
  let streak = 0;
  let weekStart = startOfWeek(fromDateKey(todayKey));
  // primeiro: a semana atual
  const countWeek = (start: Date) =>
    Array.from({ length: 7 }, (_, i) => toDateKey(addDays(start, i)))
      .filter((k) => set.has(k)).length;

  // se a semana atual já bateu, conta; se não, ignora (não quebra) e olha semanas fechadas
  const currentCount = countWeek(weekStart);
  const currentWeekDone = currentCount >= target;
  if (currentWeekDone) streak += 1;

  // semanas anteriores (fechadas): contam apenas se bateram
  weekStart = addDays(weekStart, -7);
  for (let i = 0; i < 104; i++) {
    if (countWeek(weekStart) >= target) {
      streak += 1;
      weekStart = addDays(weekStart, -7);
    } else {
      break;
    }
  }
  return streak;
}
