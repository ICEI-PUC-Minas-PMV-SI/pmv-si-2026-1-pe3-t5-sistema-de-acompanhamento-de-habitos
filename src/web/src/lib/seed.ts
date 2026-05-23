import type { SAHStore } from './storage';
import type { Habit, CheckIn } from '@/features/habits/types';
import type { User } from '@/features/auth/types';
import { addDays, fromDateKey, toDateKey } from './date';
import { makeId } from './id';

const DEMO_USER_ID = 'user-demo';

const DEMO_USER: User = {
  id: DEMO_USER_ID,
  name: 'Eduardo Demo',
  email: 'demo@sah.dev',
  password: '123456',
  createdAt: '2026-04-01',
};

const HABITS_SPEC: Array<Omit<Habit, 'id' | 'userId' | 'createdAt'>> = [
  { name: 'Beber 2L de água', category: 'saude', frequency: { kind: 'daily' },
    reminderTime: '09:00', notificationsEnabled: true, color: '#5B7FA8', icon: '💧' },
  { name: 'Ler 30 minutos', category: 'leitura', frequency: { kind: 'weekdays', days: [1, 2, 3, 4, 5] },
    reminderTime: '22:00', notificationsEnabled: true, color: '#6B5B95', icon: '📖' },
  { name: 'Exercício', category: 'exercicio', frequency: { kind: 'times-per-week', count: 4 },
    reminderTime: '07:30', notificationsEnabled: true, color: '#4A7C59', icon: '🏃' },
  { name: 'Meditar', category: 'mindfulness', frequency: { kind: 'daily' },
    reminderTime: '07:00', notificationsEnabled: false, color: '#C89B3C', icon: '🧘' },
  { name: 'Estudar React', category: 'estudo', frequency: { kind: 'weekdays', days: [2, 4] },
    reminderTime: '20:00', notificationsEnabled: true, color: '#B8544A', icon: '💻' },
];

export function buildSeed(todayKey: string): SAHStore {
  const habits: Habit[] = HABITS_SPEC.map((spec, idx) => ({
    ...spec,
    id: `habit-${idx + 1}`,
    userId: DEMO_USER_ID,
    createdAt: '2026-04-01',
  }));

  const checkIns: CheckIn[] = [];
  const today = fromDateKey(todayKey);
  for (let offset = 0; offset < 30; offset++) {
    const day = addDays(today, -offset);
    const dayKey = toDateKey(day);
    for (const habit of habits) {
      const shouldDo =
        habit.frequency.kind === 'daily' ||
        (habit.frequency.kind === 'weekdays' && habit.frequency.days.includes(day.getDay())) ||
        habit.frequency.kind === 'times-per-week';

      if (!shouldDo) continue;

      // ~75% de adesão; hábitos 1 e 4 (água, meditar) maior adesão
      const adherence = habit.id === 'habit-1' ? 0.92
                      : habit.id === 'habit-4' ? 0.85
                      : 0.7;
      if (Math.random() < adherence) {
        checkIns.push({
          id: makeId(),
          habitId: habit.id,
          userId: DEMO_USER_ID,
          date: dayKey,
          createdAt: dayKey,
        });
      }
    }
  }

  return {
    version: 1,
    session: null,
    users: [DEMO_USER],
    habits,
    checkIns,
  };
}
