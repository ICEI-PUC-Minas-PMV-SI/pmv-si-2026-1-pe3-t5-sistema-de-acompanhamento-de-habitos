import type { Session, User } from '@/features/auth/types';
import type { Habit, CheckIn } from '@/features/habits/types';

export const STORAGE_KEY = 'sah:store:v1';
export const STORAGE_VERSION = 1 as const;

export type SAHStore = {
  version: typeof STORAGE_VERSION;
  session: Session;
  users: User[];
  habits: Habit[];
  checkIns: CheckIn[];
};

export function emptyStore(): SAHStore {
  return { version: STORAGE_VERSION, session: null, users: [], habits: [], checkIns: [] };
}

export function loadStore(): SAHStore | null {
  const raw = typeof localStorage !== 'undefined' ? localStorage.getItem(STORAGE_KEY) : null;
  if (!raw) return null;
  try {
    const parsed = JSON.parse(raw) as SAHStore;
    if (parsed.version !== STORAGE_VERSION) return null;
    return parsed;
  } catch {
    return null;
  }
}

export function saveStore(store: SAHStore): void {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(store));
}

export function resetStore(): void {
  localStorage.removeItem(STORAGE_KEY);
}
