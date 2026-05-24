import { useState } from 'react';
import clsx from 'clsx';
import { Card, Heatmap, MiniBar, Badge, EmptyState } from '@/components/ui';
import { useStats, type Period } from '@/features/stats/useStats';

const PERIODS: { value: Period; label: string }[] = [
  { value: 'week', label: 'Semana' },
  { value: 'month', label: 'Mês' },
  { value: 'year', label: 'Ano' },
];

export function Estatisticas() {
  const [period, setPeriod] = useState<Period>('month');
  const stats = useStats(period);

  const columns = period === 'week' ? 7 : period === 'month' ? 7 : 52;

  return (
    <div className="space-y-5">
      <header>
        <h1 className="font-display text-2xl text-text">Estatísticas</h1>
        <p className="text-sm text-textMuted">Seu progresso ao longo do tempo</p>
      </header>

      <div className="inline-flex bg-surface border border-border rounded-full p-1">
        {PERIODS.map((p) => (
          <button key={p.value} onClick={() => setPeriod(p.value)}
            className={clsx(
              'px-4 py-1.5 text-sm rounded-full transition-colors',
              period === p.value ? 'bg-primary text-surface' : 'text-textMuted hover:text-text',
            )}>
            {p.label}
          </button>
        ))}
      </div>

      {stats.perHabit.length === 0 ? (
        <EmptyState icon="📊" title="Sem dados ainda"
          description="Crie hábitos e faça check-ins para ver estatísticas." />
      ) : (
        <>
          <Card>
            <h2 className="font-display text-lg text-text mb-3">Resumo do {periodLabel(period)}</h2>
            <div className="grid grid-cols-3 gap-3">
              <Metric label="Taxa de conclusão" value={`${stats.completionRate}%`} />
              <Metric label="Check-ins" value={stats.totalCheckIns} />
              <Metric label="Maior streak" value={`🔥 ${stats.longestStreak}`} />
            </div>
          </Card>

          <Card>
            <h2 className="font-display text-lg text-text mb-3">Mapa de check-ins</h2>
            <Heatmap cells={stats.heatmap} columns={columns} />
          </Card>

          <Card>
            <h2 className="font-display text-lg text-text mb-3">Por hábito</h2>
            <ul className="space-y-3">
              {stats.perHabit.map(({ habit, completionRate }) => (
                <li key={habit.id}>
                  <div className="flex items-center justify-between text-sm">
                    <span className="font-medium text-text">{habit.icon} {habit.name}</span>
                    <span className="text-textMuted num-tabular">{completionRate}%</span>
                  </div>
                  <MiniBar value={completionRate} color={habit.color} />
                </li>
              ))}
            </ul>
          </Card>

          <Card>
            <h2 className="font-display text-lg text-text mb-3">Maiores streaks</h2>
            <ul className="space-y-2">
              {stats.topStreaks.map(({ habit, streak }) => (
                <li key={habit.id} className="flex items-center justify-between">
                  <span className="text-text">{habit.icon} {habit.name}</span>
                  <Badge tone="streak">🔥 {streak} {streak === 1 ? 'dia' : 'dias'}</Badge>
                </li>
              ))}
            </ul>
          </Card>
        </>
      )}
    </div>
  );
}

function Metric({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div>
      <p className="text-xs text-textMuted">{label}</p>
      <p className="font-display text-xl text-text num-tabular">{value}</p>
    </div>
  );
}

function periodLabel(p: Period) {
  return p === 'week' ? 'semana' : p === 'month' ? 'mês' : 'ano';
}
