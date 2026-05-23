import { createContext, useMemo, type ReactNode } from 'react';
import { useAuth, useStore } from '@/features/auth/useAuth';
import { makeId } from '@/lib/id';
import { todayKey } from '@/lib/date';
import type { Habit, CheckIn } from './types';

export type HabitsAPI = {
  habits: Habit[];
  checkIns: CheckIn[];
  allCheckIns: CheckIn[];
  addHabit: (data: Omit<Habit, 'id' | 'userId' | 'createdAt'>) => Habit;
  updateHabit: (id: string, patch: Partial<Habit>) => void;
  deleteHabit: (id: string) => void;
  checkIn: (habitId: string, date?: string) => void;
  uncheckIn: (habitId: string, date?: string) => void;
};

export const HabitsContext = createContext<HabitsAPI | null>(null);

export function HabitsProvider({ children }: { children: ReactNode }) {
  const { currentUser } = useAuth();
  const { store, setStore } = useStore();

  const habits = useMemo(
    () => currentUser ? store.habits.filter((h) => h.userId === currentUser.id && !h.archivedAt) : [],
    [currentUser, store.habits],
  );

  const checkIns = useMemo(
    () => currentUser ? store.checkIns.filter((c) => c.userId === currentUser.id) : [],
    [currentUser, store.checkIns],
  );

  const addHabit: HabitsAPI['addHabit'] = (data) => {
    if (!currentUser) throw new Error('Sem usuário autenticado');
    const habit: Habit = {
      ...data,
      id: makeId(),
      userId: currentUser.id,
      createdAt: new Date().toISOString(),
    };
    setStore((s) => ({ ...s, habits: [...s.habits, habit] }));
    return habit;
  };

  const updateHabit: HabitsAPI['updateHabit'] = (id, patch) => {
    setStore((s) => ({
      ...s,
      habits: s.habits.map((h) => (h.id === id ? { ...h, ...patch } : h)),
    }));
  };

  const deleteHabit: HabitsAPI['deleteHabit'] = (id) => {
    setStore((s) => ({
      ...s,
      habits: s.habits.filter((h) => h.id !== id),
      checkIns: s.checkIns.filter((c) => c.habitId !== id),
    }));
  };

  const checkIn: HabitsAPI['checkIn'] = (habitId, date) => {
    if (!currentUser) return;
    const day = date ?? todayKey();
    setStore((s) => {
      const exists = s.checkIns.some(
        (c) => c.habitId === habitId && c.date === day && c.userId === currentUser.id,
      );
      if (exists) return s;
      const entry: CheckIn = {
        id: makeId(),
        habitId,
        userId: currentUser.id,
        date: day,
        createdAt: new Date().toISOString(),
      };
      return { ...s, checkIns: [...s.checkIns, entry] };
    });
  };

  const uncheckIn: HabitsAPI['uncheckIn'] = (habitId, date) => {
    if (!currentUser) return;
    const day = date ?? todayKey();
    setStore((s) => ({
      ...s,
      checkIns: s.checkIns.filter(
        (c) => !(c.habitId === habitId && c.date === day && c.userId === currentUser.id),
      ),
    }));
  };

  return (
    <HabitsContext.Provider value={{
      habits, checkIns, allCheckIns: checkIns,
      addHabit, updateHabit, deleteHabit, checkIn, uncheckIn,
    }}>
      {children}
    </HabitsContext.Provider>
  );
}
