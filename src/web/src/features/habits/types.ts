export type HabitFrequency =
  | { kind: 'daily' }
  | { kind: 'weekdays'; days: number[] }
  | { kind: 'times-per-week'; count: number };

export type Habit = {
  id: string;
  userId: string;
  name: string;
  category: string;
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
