import { useMemo, useState } from 'react';
import clsx from 'clsx';
import { Card, EmptyState, Badge } from '@/components/ui';
import { useLogs } from '@/features/logs/useLogs';
import type { LogType } from '@/features/logs/types';

const TYPES: { value: LogType | 'all'; label: string }[] = [
  { value: 'all', label: 'Todos' },
  { value: 'auth', label: 'Auth' },
  { value: 'habito', label: 'Hábito' },
  { value: 'moderacao', label: 'Moderação' },
  { value: 'sistema', label: 'Sistema' },
];

const LOG_ICON: Record<LogType, string> = {
  auth: '🔑', habito: '✅', moderacao: '🛡️', sistema: '⚙️',
};

function fmt(iso: string): string {
  const d = new Date(iso);
  return d.toLocaleString('pt-BR', { day: '2-digit', month: '2-digit', hour: '2-digit', minute: '2-digit' });
}

export function AdminLogs() {
  const { logs } = useLogs();
  const [filter, setFilter] = useState<LogType | 'all'>('all');

  const visible = useMemo(
    () => (filter === 'all' ? logs : logs.filter((l) => l.type === filter)),
    [logs, filter],
  );

  return (
    <div className="space-y-4">
      <header>
        <h1 className="font-display text-2xl text-text">Logs do sistema</h1>
        <p className="text-sm text-textMuted">Eventos da plataforma</p>
      </header>

      <div className="inline-flex flex-wrap gap-1 bg-surface border border-border rounded-full p-1">
        {TYPES.map((t) => (
          <button key={t.value} onClick={() => setFilter(t.value)}
            className={clsx('px-3 py-1.5 text-sm rounded-full transition-colors',
              filter === t.value ? 'bg-primary text-surface' : 'text-textMuted hover:text-text')}>
            {t.label}
          </button>
        ))}
      </div>

      {visible.length === 0 ? (
        <EmptyState icon="📜" title="Nenhum log" description="Nenhum evento para este filtro." />
      ) : (
        <ul className="space-y-2">
          {visible.map((log) => (
            <li key={log.id}>
              <Card className="flex items-center gap-3">
                <span className="text-lg">{LOG_ICON[log.type]}</span>
                <div className="flex-1 min-w-0">
                  <p className="text-sm text-text">{log.message}</p>
                  <p className="text-xs text-textFaint num-tabular">{fmt(log.createdAt)}</p>
                </div>
                <Badge tone="neutral" size="sm">{log.type}</Badge>
              </Card>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
