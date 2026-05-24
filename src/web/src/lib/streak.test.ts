import { describe, it, expect } from 'vitest';
import { computeStreak } from './streak';
import type { Habit, CheckIn } from '@/features/habits/types';

const baseHabit = (over: Partial<Habit>): Habit => ({
  id: 'h1', userId: 'u1', name: 'Beber água',
  category: 'saude', frequency: { kind: 'daily' },
  notificationsEnabled: false, color: '#4A7C59', icon: '💧',
  createdAt: '2026-04-01',
  ...over,
});

const ci = (date: string): CheckIn => ({
  id: `c-${date}`, habitId: 'h1', userId: 'u1', date, createdAt: date,
});

describe('computeStreak', () => {
  it('daily: 3 dias consecutivos até hoje', () => {
    const habit = baseHabit({ frequency: { kind: 'daily' } });
    const checks = [ci('2026-05-19'), ci('2026-05-20'), ci('2026-05-21')];
    expect(computeStreak(habit, checks, '2026-05-21')).toBe(3);
  });

  it('daily: streak quebrado retorna 0 se hoje sem check-in', () => {
    const habit = baseHabit({ frequency: { kind: 'daily' } });
    const checks = [ci('2026-05-19'), ci('2026-05-20')];
    // 2026-05-22: nem hoje nem ontem (21) → 0
    expect(computeStreak(habit, checks, '2026-05-22')).toBe(0);
  });

  it('daily: hoje sem check-in mas ontem sim → streak começa em ontem', () => {
    const habit = baseHabit({ frequency: { kind: 'daily' } });
    const checks = [ci('2026-05-19'), ci('2026-05-20')];
    // 2026-05-21 sem check-in, mas ontem (20) e anteontem (19) bateram → streak 2 (do dia 20 pra trás)
    expect(computeStreak(habit, checks, '2026-05-21')).toBe(2);
  });

  it('weekdays: só conta os dias agendados', () => {
    // segunda a sexta (1..5)
    const habit = baseHabit({ frequency: { kind: 'weekdays', days: [1, 2, 3, 4, 5] } });
    // 2026-05-18 = seg, 19=ter, 20=qua, 21=qui (hoje)
    const checks = [ci('2026-05-18'), ci('2026-05-19'), ci('2026-05-20'), ci('2026-05-21')];
    expect(computeStreak(habit, checks, '2026-05-21')).toBe(4);
  });

  it('weekdays: pula dias não agendados sem quebrar', () => {
    const habit = baseHabit({ frequency: { kind: 'weekdays', days: [1, 3, 5] } });
    // dias agendados na semana: seg 18, qua 20, sex 22
    // imagine hoje = sex 22, todos bateram
    const checks = [ci('2026-05-18'), ci('2026-05-20'), ci('2026-05-22')];
    expect(computeStreak(habit, checks, '2026-05-22')).toBe(3);
  });

  it('times-per-week: conta semanas que bateram a meta', () => {
    const habit = baseHabit({ frequency: { kind: 'times-per-week', count: 3 } });
    // semana atual (dom 17 → sáb 23): 3 check-ins (seg 18, ter 19, qua 20)
    // semana anterior (dom 10 → sáb 16): 3 check-ins
    const checks = [
      ci('2026-05-11'), ci('2026-05-13'), ci('2026-05-15'),
      ci('2026-05-18'), ci('2026-05-19'), ci('2026-05-20'),
    ];
    expect(computeStreak(habit, checks, '2026-05-21')).toBe(2);
  });

  it('times-per-week: semana incompleta atual não quebra streak', () => {
    const habit = baseHabit({ frequency: { kind: 'times-per-week', count: 3 } });
    // semana atual com 1 check-in (insuficiente), semana anterior 3
    const checks = [
      ci('2026-05-11'), ci('2026-05-13'), ci('2026-05-15'),
      ci('2026-05-18'),
    ];
    // semana atual ainda não fechou; conta semana anterior
    expect(computeStreak(habit, checks, '2026-05-21')).toBe(1);
  });

  it('sem check-ins → 0', () => {
    expect(computeStreak(baseHabit({}), [], '2026-05-21')).toBe(0);
  });
});
