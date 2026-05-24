import { useContext } from 'react';
import { HabitsContext } from './HabitsContext';

export function useHabits() {
  const ctx = useContext(HabitsContext);
  if (!ctx) throw new Error('useHabits must be used within HabitsProvider');
  return ctx;
}
