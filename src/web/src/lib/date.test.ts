import { describe, it, expect } from 'vitest';
import {
  toDateKey, fromDateKey, todayKey, addDays,
  startOfWeek, weekKeysOf, startOfMonth, monthKeysOf, daysBetween,
} from './date';

describe('date helpers', () => {
  it('toDateKey produz YYYY-MM-DD', () => {
    expect(toDateKey(new Date(2026, 4, 21))).toBe('2026-05-21');
  });

  it('fromDateKey reverte para Date local', () => {
    const d = fromDateKey('2026-05-21');
    expect(d.getFullYear()).toBe(2026);
    expect(d.getMonth()).toBe(4);
    expect(d.getDate()).toBe(21);
  });

  it('todayKey retorna 10 chars YYYY-MM-DD', () => {
    expect(todayKey()).toMatch(/^\d{4}-\d{2}-\d{2}$/);
  });

  it('addDays soma corretamente atravessando mês', () => {
    expect(toDateKey(addDays(new Date(2026, 4, 30), 3))).toBe('2026-06-02');
  });

  it('startOfWeek volta para domingo', () => {
    // 2026-05-21 = quinta, semana começa em 2026-05-17 (dom)
    expect(toDateKey(startOfWeek(new Date(2026, 4, 21)))).toBe('2026-05-17');
  });

  it('weekKeysOf retorna 7 dias dom→sáb', () => {
    const keys = weekKeysOf(new Date(2026, 4, 21));
    expect(keys).toHaveLength(7);
    expect(keys[0]).toBe('2026-05-17');
    expect(keys[6]).toBe('2026-05-23');
  });

  it('startOfMonth volta para dia 1', () => {
    expect(toDateKey(startOfMonth(new Date(2026, 4, 21)))).toBe('2026-05-01');
  });

  it('monthKeysOf retorna todos os dias do mês', () => {
    const keys = monthKeysOf(new Date(2026, 4, 21));
    expect(keys).toHaveLength(31);
    expect(keys[0]).toBe('2026-05-01');
    expect(keys[30]).toBe('2026-05-31');
  });

  it('daysBetween conta diferença em dias', () => {
    expect(daysBetween('2026-05-01', '2026-05-10')).toBe(9);
    expect(daysBetween('2026-05-10', '2026-05-01')).toBe(-9);
  });
});
