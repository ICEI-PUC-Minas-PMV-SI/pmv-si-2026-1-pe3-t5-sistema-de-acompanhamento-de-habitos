import { describe, it, expect } from 'vitest';
import { buildSeed } from './seed';

describe('buildSeed', () => {
  const seed = buildSeed('2026-05-21');

  it('cria 1 usuário demo', () => {
    expect(seed.users).toHaveLength(1);
    expect(seed.users[0].email).toBe('demo@sah.dev');
    expect(seed.users[0].password).toBe('123456');
  });

  it('cria 5 hábitos para o usuário demo', () => {
    expect(seed.habits).toHaveLength(5);
    expect(seed.habits.every((h) => h.userId === seed.users[0].id)).toBe(true);
  });

  it('cria entre 60 e 130 check-ins no último mês', () => {
    expect(seed.checkIns.length).toBeGreaterThanOrEqual(60);
    expect(seed.checkIns.length).toBeLessThanOrEqual(130);
  });

  it('todos os check-ins estão dentro dos últimos 30 dias', () => {
    const minDate = new Date('2026-04-21');
    seed.checkIns.forEach((c) => {
      expect(new Date(c.date).getTime()).toBeGreaterThanOrEqual(minDate.getTime());
    });
  });

  it('session inicia null (login manual)', () => {
    expect(seed.session).toBeNull();
  });
});
