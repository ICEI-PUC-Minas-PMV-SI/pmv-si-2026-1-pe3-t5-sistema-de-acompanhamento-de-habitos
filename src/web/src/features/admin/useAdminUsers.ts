import { useMemo } from 'react';
import { useStore } from '@/features/auth/useAuth';
import type { User } from '@/features/auth/types';

export type AdminUserRow = { user: User; habitCount: number };

export function useAdminUsers() {
  const { store, setStore } = useStore();

  const rows: AdminUserRow[] = useMemo(
    () => store.users.map((user) => ({
      user,
      habitCount: store.habits.filter((h) => h.userId === user.id && !h.archivedAt).length,
    })),
    [store.users, store.habits],
  );

  const setBlocked = (id: string, blocked: boolean) => {
    setStore((s) => ({
      ...s,
      users: s.users.map((u) => (u.id === id ? { ...u, blocked } : u)),
    }));
  };

  const blockUser = (id: string) => setBlocked(id, true);
  const unblockUser = (id: string) => setBlocked(id, false);

  return { rows, blockUser, unblockUser };
}
