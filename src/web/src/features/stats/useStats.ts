import { useMemo } from 'react';
import { useHabits } from '@/features/habits/useHabits';
import { computeStreak } from '@/lib/streak';
import { addDays, fromDateKey, todayKey, toDateKey, weekKeysOf, monthKeysOf, startOfWeek, startOfMonth } from '@/lib/date';
import type { Habit } from '@/features/habits/types';

export type Period = 'week' | 'month' | 'year';

export type StatsResult = {
  rangeKeys: string[];
  totalCheckIns: number;
  completionRate: number;
  longestStreak: number;
  perHabit: Array<{ habit: Habit; streak: number; completionRate: number }>;
  topStreaks: Array<{ habit: Habit; streak: number }>;
  heatmap: Array<{ date: string; count: number }>;
};

export function useStats(period: Period): StatsResult {
  const { habits, checkIns } = useHabits();

  return useMemo(() => {
    const today = todayKey();
    let rangeKeys: string[] = [];
    if (period === 'week') {
      rangeKeys = weekKeysOf(fromDateKey(today));
    } else if (period === 'month') {
      rangeKeys = monthKeysOf(fromDateKey(today));
    } else {
      // ano: últimas 52 semanas (heatmap em forma de grade)
      const start = addDays(startOfWeek(fromDateKey(today)), -7 * 51);
      rangeKeys = Array.from({ length: 7 * 52 }, (_, i) => toDateKey(addDays(start, i)));
    }
    const rangeSet = new Set(rangeKeys);

    const checksInRange = checkIns.filter((c) => rangeSet.has(c.date));

    const expectedTotal = habits.reduce((acc, h) => {
      const expected = rangeKeys.filter((k) => isScheduled(h, k)).length;
      return acc + expected;
    }, 0);

    const completionRate = expectedTotal > 0
      ? Math.round((checksInRange.length / expectedTotal) * 100)
      : 0;

    const perHabit = habits.map((h) => {
      const expected = rangeKeys.filter((k) => isScheduled(h, k)).length;
      const done = checksInRange.filter((c) => c.habitId === h.id).length;
      return {
        habit: h,
        streak: computeStreak(h, checkIns, today),
        completionRate: expected > 0 ? Math.round((done / expected) * 100) : 0,
      };
    });

    const longestStreak = perHabit.reduce((m, x) => Math.max(m, x.streak), 0);

    const topStreaks = [...perHabit]
      .sort((a, b) => b.streak - a.streak)
      .slice(0, 3)
      .map((x) => ({ habit: x.habit, streak: x.streak }));

    const heatmap = rangeKeys.map((date) => ({
      date,
      count: checksInRange.filter((c) => c.date === date).length,
    }));

    return { rangeKeys, totalCheckIns: checksInRange.length, completionRate, longestStreak, perHabit, topStreaks, heatmap };
  }, [habits, checkIns, period]);
}

function isScheduled(habit: Habit, dateKey: string): boolean {
  if (habit.frequency.kind === 'daily') return true;
  if (habit.frequency.kind === 'weekdays') {
    return habit.frequency.days.includes(fromDateKey(dateKey).getDay());
  }
  // times-per-week: contamos todo dia como elegível para evitar bias na expectativa
  return true;
}

// reexport for date functions used in heatmap rendering
export { weekKeysOf, monthKeysOf, startOfMonth, startOfWeek };
