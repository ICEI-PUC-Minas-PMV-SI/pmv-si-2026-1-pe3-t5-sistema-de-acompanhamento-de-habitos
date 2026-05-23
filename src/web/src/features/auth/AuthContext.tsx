import { createContext, useEffect, useMemo, useState, type ReactNode } from 'react';
import { loadStore, saveStore, type SAHStore } from '@/lib/storage';
import { buildSeed } from '@/lib/seed';
import { todayKey } from '@/lib/date';
import { makeId } from '@/lib/id';
import type { User } from './types';

export type AuthAPI = {
  currentUser: User | null;
  signIn: (email: string, password: string) => Promise<{ ok: true } | { ok: false; error: string }>;
  signUp: (name: string, email: string, password: string) => Promise<{ ok: true } | { ok: false; error: string }>;
  signOut: () => void;
};

export const StoreContext = createContext<{
  store: SAHStore;
  setStore: (updater: (s: SAHStore) => SAHStore) => void;
} | null>(null);

export const AuthContext = createContext<AuthAPI | null>(null);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [store, setStoreState] = useState<SAHStore>(() => {
    const loaded = loadStore();
    if (loaded && loaded.users.length > 0) return loaded;
    return buildSeed(todayKey());
  });

  useEffect(() => { saveStore(store); }, [store]);

  const setStore = (updater: (s: SAHStore) => SAHStore) => setStoreState(updater);

  const currentUser = useMemo(
    () => store.session ? store.users.find((u) => u.id === store.session!.userId) ?? null : null,
    [store.session, store.users],
  );

  const signIn: AuthAPI['signIn'] = async (email, password) => {
    const user = store.users.find((u) => u.email.toLowerCase() === email.toLowerCase());
    if (!user || user.password !== password) {
      return { ok: false, error: 'E-mail ou senha incorretos.' };
    }
    setStore((s) => ({ ...s, session: { userId: user.id } }));
    return { ok: true };
  };

  const signUp: AuthAPI['signUp'] = async (name, email, password) => {
    if (store.users.some((u) => u.email.toLowerCase() === email.toLowerCase())) {
      return { ok: false, error: 'Já existe uma conta com esse e-mail.' };
    }
    const newUser: User = {
      id: makeId(), name, email, password,
      createdAt: new Date().toISOString(),
    };
    setStore((s) => ({
      ...s,
      users: [...s.users, newUser],
      session: { userId: newUser.id },
    }));
    return { ok: true };
  };

  const signOut = () => setStore((s) => ({ ...s, session: null }));

  return (
    <StoreContext.Provider value={{ store, setStore }}>
      <AuthContext.Provider value={{ currentUser, signIn, signUp, signOut }}>
        {children}
      </AuthContext.Provider>
    </StoreContext.Provider>
  );
}
