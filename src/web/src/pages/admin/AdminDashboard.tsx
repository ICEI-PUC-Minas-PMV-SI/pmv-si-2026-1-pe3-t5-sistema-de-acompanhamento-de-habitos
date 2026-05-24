import { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card, Button, Spinner, Badge } from '@/components/ui';
import { useStore } from '@/features/auth/useAuth';
import { useLogs } from '@/features/logs/useLogs';

const LOG_ICON: Record<string, string> = {
  auth: '🔑', habito: '✅', moderacao: '🛡️', sistema: '⚙️',
};

function Metric({ label, value }: { label: string; value: number }) {
  return (
    <Card>
      <p className="text-xs text-textMuted">{label}</p>
      <p className="font-display text-2xl text-text num-tabular">{value}</p>
    </Card>
  );
}

export function AdminDashboard() {
  const { store } = useStore();
  const { logs } = useLogs();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const t = setTimeout(() => setLoading(false), 600);
    return () => clearTimeout(t);
  }, []);

  const metrics = useMemo(() => ({
    totalUsers: store.users.length,
    active: store.users.filter((u) => !u.blocked).length,
    blocked: store.users.filter((u) => u.blocked).length,
    habits: store.habits.length,
    checkIns: store.checkIns.length,
    categories: store.categories.length,
  }), [store]);

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center py-24 text-textMuted gap-3">
        <Spinner size={28} />
        <p className="text-sm">Carregando painel…</p>
      </div>
    );
  }

  return (
    <div className="space-y-5">
      <header>
        <h1 className="font-display text-2xl text-text">Painel administrativo</h1>
        <p className="text-sm text-textMuted">Visão geral da plataforma</p>
      </header>

      {metrics.categories === 0 && (
        <Card className="border-info/30 bg-infoSoft">
          <h2 className="font-display text-lg text-text">Configure as categorias padrão</h2>
          <p className="text-sm text-textMuted mt-1">
            Ainda não há categorias globais. Defina as categorias que os usuários poderão usar.
          </p>
          <Link to="/admin/categorias" className="inline-block mt-3">
            <Button size="sm">Configurar categorias</Button>
          </Link>
        </Card>
      )}

      <section className="grid grid-cols-2 sm:grid-cols-3 gap-3">
        <Metric label="Usuários" value={metrics.totalUsers} />
        <Metric label="Ativos" value={metrics.active} />
        <Metric label="Bloqueados" value={metrics.blocked} />
        <Metric label="Hábitos" value={metrics.habits} />
        <Metric label="Check-ins" value={metrics.checkIns} />
        <Metric label="Categorias" value={metrics.categories} />
      </section>

      <Card>
        <h2 className="font-display text-lg text-text mb-3">Atividade recente</h2>
        <ul className="space-y-2">
          {logs.slice(0, 5).map((log) => (
            <li key={log.id} className="flex items-center gap-2 text-sm">
              <span>{LOG_ICON[log.type] ?? '•'}</span>
              <span className="text-text flex-1 truncate">{log.message}</span>
              <Badge tone="neutral" size="sm">{log.type}</Badge>
            </li>
          ))}
        </ul>
      </Card>
    </div>
  );
}
