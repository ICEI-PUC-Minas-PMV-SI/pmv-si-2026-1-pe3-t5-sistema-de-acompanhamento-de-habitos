import { describe, it, expect } from 'vitest';
import { buildSeed } from './seed';

describe('buildSeed', () => {
  const seed = buildSeed('2026-05-21');
  const demo = seed.users.find((u) => u.email === 'demo@sah.dev')!;

  it('inclui usuário demo (role user)', () => {
    expect(demo).toBeTruthy();
    expect(demo.password).toBe('123456');
    expect(demo.role).toBe('user');
  });

  it('inclui moderadora marina@sah.dev (role moderator)', () => {
    const marina = seed.users.find((u) => u.email === 'marina@sah.dev');
    expect(marina).toBeTruthy();
    expect(marina!.role).toBe('moderator');
    expect(marina!.password).toBe('123456');
  });

  it('inclui ao menos um usuário bloqueado', () => {
    expect(seed.users.some((u) => u.blocked === true)).toBe(true);
  });

  it('demo tem 5 hábitos', () => {
    const demoHabits = seed.habits.filter((h) => h.userId === demo.id);
    expect(demoHabits).toHaveLength(5);
  });

  it('cria entre 60 e 130 check-ins do demo no último mês', () => {
    const demoChecks = seed.checkIns.filter((c) => c.userId === demo.id);
    expect(demoChecks.length).toBeGreaterThanOrEqual(60);
    expect(demoChecks.length).toBeLessThanOrEqual(130);
  });

  it('cria 6 categorias globais com ids estáveis', () => {
    expect(seed.categories).toHaveLength(6);
    const ids = seed.categories.map((c) => c.id).sort();
    expect(ids).toEqual(['estudo', 'exercicio', 'leitura', 'mindfulness', 'outros', 'saude']);
  });

  it('cria ao menos 15 logs cobrindo os 4 tipos', () => {
    expect(seed.logs.length).toBeGreaterThanOrEqual(15);
    const types = new Set(seed.logs.map((l) => l.type));
    expect(types.has('auth')).toBe(true);
    expect(types.has('habito')).toBe(true);
    expect(types.has('moderacao')).toBe(true);
    expect(types.has('sistema')).toBe(true);
  });

  it('session inicia null (login manual)', () => {
    expect(seed.session).toBeNull();
  });
});
