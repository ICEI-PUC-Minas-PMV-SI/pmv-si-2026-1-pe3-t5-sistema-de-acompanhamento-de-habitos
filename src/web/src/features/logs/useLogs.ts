import { useMemo } from 'react';
import { useStore } from '@/features/auth/useAuth';
import type { LogEntry } from './types';

export function useLogs(): { logs: LogEntry[] } {
  const { store } = useStore();
  const logs = useMemo(
    () => [...store.logs].sort((a, b) => b.createdAt.localeCompare(a.createdAt)),
    [store.logs],
  );
  return { logs };
}
