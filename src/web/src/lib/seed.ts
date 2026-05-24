import type { SAHStore } from './storage';
import type { Habit, CheckIn } from '@/features/habits/types';
import type { User } from '@/features/auth/types';
import type { Category } from '@/features/categories/types';
import type { LogEntry } from '@/features/logs/types';
import { addDays, fromDateKey, toDateKey } from './date';
import { makeId } from './id';

const DEMO_USER_ID = 'user-demo';
const MARINA_ID = 'user-marina';

const CATEGORIES: Category[] = [
  { id: 'saude',       label: 'Saúde',       icon: '🩺' },
  { id: 'estudo',      label: 'Estudo',      icon: '📚' },
  { id: 'exercicio',   label: 'Exercício',   icon: '🏃' },
  { id: 'leitura',     label: 'Leitura',     icon: '📖' },
  { id: 'mindfulness', label: 'Mindfulness', icon: '🧘' },
  { id: 'outros',      label: 'Outros',      icon: '🎯' },
];

const USERS: User[] = [
  { id: DEMO_USER_ID, name: 'Eduardo Demo', email: 'demo@sah.dev', password: '123456', role: 'user', createdAt: '2026-04-01' },
  { id: MARINA_ID, name: 'Marina Costa', email: 'marina@sah.dev', password: '123456', role: 'moderator', createdAt: '2026-03-15' },
  { id: 'user-ana', name: 'Ana Souza', email: 'ana@sah.dev', password: '123456', role: 'user', createdAt: '2026-04-10' },
  { id: 'user-bruno', name: 'Bruno Lima', email: 'bruno@sah.dev', password: '123456', role: 'user', createdAt: '2026-04-18' },
  { id: 'user-carla', name: 'Carla Dias', email: 'carla@sah.dev', password: '123456', role: 'user', blocked: true, createdAt: '2026-04-22' },
];

const DEMO_HABITS_SPEC: Array<Omit<Habit, 'id' | 'userId' | 'createdAt'>> = [
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

// Hábitos extras de outros usuários (poucos), para a coluna "nº de hábitos" variar.
const EXTRA_HABITS: Habit[] = [
  { id: 'habit-ana-1', userId: 'user-ana', name: 'Caminhar', category: 'exercicio', frequency: { kind: 'daily' },
    notificationsEnabled: false, color: '#4A7C59', icon: '🚶', createdAt: '2026-04-11' },
  { id: 'habit-ana-2', userId: 'user-ana', name: 'Ler notícias', category: 'leitura', frequency: { kind: 'daily' },
    notificationsEnabled: false, color: '#6B5B95', icon: '📰', createdAt: '2026-04-11' },
  { id: 'habit-bruno-1', userId: 'user-bruno', name: 'Academia', category: 'exercicio', frequency: { kind: 'times-per-week', count: 3 },
    notificationsEnabled: true, color: '#4A7C59', icon: '💪', createdAt: '2026-04-19' },
];

function buildLogs(todayKey: string): LogEntry[] {
  const t = fromDateKey(todayKey);
  const at = (offset: number, h = 9) => {
    const d = addDays(t, -offset);
    d.setHours(h, 0, 0, 0);
    return d.toISOString();
  };
  return [
    { id: makeId(), type: 'sistema',   message: 'Backup automático concluído com sucesso.', createdAt: at(0, 3) },
    { id: makeId(), type: 'auth',      message: 'Login: marina@sah.dev (moderadora).', userId: MARINA_ID, createdAt: at(0, 8) },
    { id: makeId(), type: 'habito',    message: 'Check-in registrado: Beber 2L de água.', userId: DEMO_USER_ID, createdAt: at(0, 9) },
    { id: makeId(), type: 'moderacao', message: 'Marina bloqueou o usuário Carla Dias.', userId: MARINA_ID, createdAt: at(1, 14) },
    { id: makeId(), type: 'auth',      message: 'Novo cadastro: bruno@sah.dev.', userId: 'user-bruno', createdAt: at(1, 10) },
    { id: makeId(), type: 'habito',    message: 'Novo hábito criado: Academia.', userId: 'user-bruno', createdAt: at(1, 11) },
    { id: makeId(), type: 'auth',      message: 'Login: demo@sah.dev.', userId: DEMO_USER_ID, createdAt: at(2, 8) },
    { id: makeId(), type: 'habito',    message: 'Check-in registrado: Meditar.', userId: DEMO_USER_ID, createdAt: at(2, 7) },
    { id: makeId(), type: 'sistema',   message: 'Categoria global atualizada: Saúde.', createdAt: at(2, 16) },
    { id: makeId(), type: 'moderacao', message: 'Marina editou a categoria "Estudo".', userId: MARINA_ID, createdAt: at(3, 15) },
    { id: makeId(), type: 'auth',      message: 'Novo cadastro: ana@sah.dev.', userId: 'user-ana', createdAt: at(4, 9) },
    { id: makeId(), type: 'habito',    message: 'Novo hábito criado: Caminhar.', userId: 'user-ana', createdAt: at(4, 10) },
    { id: makeId(), type: 'sistema',   message: 'Manutenção programada finalizada.', createdAt: at(5, 2) },
    { id: makeId(), type: 'auth',      message: 'Login: ana@sah.dev.', userId: 'user-ana', createdAt: at(5, 19) },
    { id: makeId(), type: 'habito',    message: 'Check-in registrado: Exercício.', userId: DEMO_USER_ID, createdAt: at(6, 18) },
    { id: makeId(), type: 'moderacao', message: 'Marina visualizou os logs do sistema.', userId: MARINA_ID, createdAt: at(6, 12) },
    { id: makeId(), type: 'sistema',   message: 'Seed de demonstração carregado.', createdAt: at(7, 1) },
  ];
}

export function buildSeed(todayKey: string): SAHStore {
  const demoHabits: Habit[] = DEMO_HABITS_SPEC.map((spec, idx) => ({
    ...spec,
    id: `habit-${idx + 1}`,
    userId: DEMO_USER_ID,
    createdAt: '2026-04-01',
  }));

  const habits: Habit[] = [...demoHabits, ...EXTRA_HABITS];

  const checkIns: CheckIn[] = [];
  const today = fromDateKey(todayKey);
  for (let offset = 0; offset < 30; offset++) {
    const day = addDays(today, -offset);
    const dayKey = toDateKey(day);
    for (const habit of demoHabits) {
      const shouldDo =
        habit.frequency.kind === 'daily' ||
        (habit.frequency.kind === 'weekdays' && habit.frequency.days.includes(day.getDay())) ||
        habit.frequency.kind === 'times-per-week';

      if (!shouldDo) continue;

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
    version: 2,
    session: null,
    users: USERS,
    habits,
    checkIns,
    categories: CATEGORIES,
    logs: buildLogs(todayKey),
  };
}
