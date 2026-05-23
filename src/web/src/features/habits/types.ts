export type HabitCategory =
  | 'saude' | 'estudo' | 'exercicio' | 'leitura' | 'mindfulness' | 'outros';

export const HABIT_CATEGORIES: { value: HabitCategory; label: string }[] = [
  { value: 'saude',       label: 'Saúde' },
  { value: 'estudo',      label: 'Estudo' },
  { value: 'exercicio',   label: 'Exercício' },
  { value: 'leitura',     label: 'Leitura' },
  { value: 'mindfulness', label: 'Mindfulness' },
  { value: 'outros',      label: 'Outros' },
];

export type HabitFrequency =
  | { kind: 'daily' }
  | { kind: 'weekdays'; days: number[] }
  | { kind: 'times-per-week'; count: number };

export type Habit = {
  id: string;
  userId: string;
  name: string;
  category: HabitCategory;
  frequency: HabitFrequency;
  reminderTime?: string;
  notificationsEnabled: boolean;
  color: string;
  icon: string;
  createdAt: string;
  archivedAt?: string;
};

export type CheckIn = {
  id: string;
  habitId: string;
  userId: string;
  date: string;
  createdAt: string;
};
