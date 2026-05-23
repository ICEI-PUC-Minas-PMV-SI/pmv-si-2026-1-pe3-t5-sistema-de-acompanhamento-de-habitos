import { describe, it, expect, beforeEach } from 'vitest';
import { loadStore, saveStore, resetStore, STORAGE_KEY, emptyStore } from './storage';

beforeEach(() => localStorage.clear());

describe('storage', () => {
  it('loadStore retorna null quando nada salvo', () => {
    expect(loadStore()).toBeNull();
  });

  it('saveStore + loadStore roundtrip', () => {
    const store = emptyStore();
    store.users.push({ id: 'u1', name: 'a', email: 'a@b', password: 'x', createdAt: '2026-05-21' });
    saveStore(store);
    const loaded = loadStore();
    expect(loaded?.users[0].id).toBe('u1');
  });

  it('resetStore remove a chave', () => {
    saveStore(emptyStore());
    expect(localStorage.getItem(STORAGE_KEY)).not.toBeNull();
    resetStore();
    expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
  });

  it('loadStore retorna null com JSON corrompido', () => {
    localStorage.setItem(STORAGE_KEY, '{not valid json');
    expect(loadStore()).toBeNull();
  });

  it('loadStore retorna null se versão for diferente', () => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify({ version: 99 }));
    expect(loadStore()).toBeNull();
  });
});
