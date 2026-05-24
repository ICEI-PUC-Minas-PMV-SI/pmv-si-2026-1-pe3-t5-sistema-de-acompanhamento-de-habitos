import { describe, it, expect, beforeEach } from 'vitest';
import { loadStore, saveStore, resetStore, STORAGE_KEY, STORAGE_VERSION, emptyStore } from './storage';

beforeEach(() => localStorage.clear());

describe('storage', () => {
  it('loadStore retorna null quando nada salvo', () => {
    expect(loadStore()).toBeNull();
  });

  it('emptyStore inclui categories e logs vazios e versão atual', () => {
    const s = emptyStore();
    expect(s.version).toBe(STORAGE_VERSION);
    expect(s.categories).toEqual([]);
    expect(s.logs).toEqual([]);
  });

  it('saveStore + loadStore roundtrip', () => {
    const store = emptyStore();
    store.users.push({ id: 'u1', name: 'a', email: 'a@b', password: 'x', role: 'user', createdAt: '2026-05-21' });
    store.categories.push({ id: 'saude', label: 'Saúde', icon: '🩺' });
    saveStore(store);
    const loaded = loadStore();
    expect(loaded?.users[0].id).toBe('u1');
    expect(loaded?.categories[0].id).toBe('saude');
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

  it('loadStore retorna null se versão for diferente (v1 antigo)', () => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify({ version: 1 }));
    expect(loadStore()).toBeNull();
  });
});
