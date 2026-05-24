import { useMemo, useState } from 'react';
import clsx from 'clsx';
import { Card, Button, Badge, Input, EmptyState } from '@/components/ui';
import { useAuth } from '@/features/auth/useAuth';
import { useAdminUsers, type AdminUserRow } from '@/features/admin/useAdminUsers';

type SortKey = 'name' | 'email' | 'role' | 'habitCount' | 'status';

export function AdminUsuarios() {
  const { currentUser } = useAuth();
  const { rows, blockUser, unblockUser } = useAdminUsers();
  const [query, setQuery] = useState('');
  const [sortKey, setSortKey] = useState<SortKey>('name');
  const [asc, setAsc] = useState(true);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    const base = q
      ? rows.filter((r) => r.user.name.toLowerCase().includes(q) || r.user.email.toLowerCase().includes(q))
      : rows;
    const val = (r: AdminUserRow): string | number => {
      switch (sortKey) {
        case 'name': return r.user.name.toLowerCase();
        case 'email': return r.user.email.toLowerCase();
        case 'role': return r.user.role;
        case 'habitCount': return r.habitCount;
        case 'status': return r.user.blocked ? 1 : 0;
      }
    };
    return [...base].sort((a, b) => {
      const av = val(a), bv = val(b);
      const cmp = av < bv ? -1 : av > bv ? 1 : 0;
      return asc ? cmp : -cmp;
    });
  }, [rows, query, sortKey, asc]);

  const toggleSort = (key: SortKey) => {
    if (key === sortKey) setAsc((v) => !v);
    else { setSortKey(key); setAsc(true); }
  };

  const Th = ({ k, children, className }: { k: SortKey; children: React.ReactNode; className?: string }) => (
    <th className={clsx('text-left font-medium text-textMuted px-3 py-2 cursor-pointer select-none', className)}
        onClick={() => toggleSort(k)}>
      {children}{sortKey === k ? (asc ? ' ▲' : ' ▼') : ''}
    </th>
  );

  return (
    <div className="space-y-4">
      <header>
        <h1 className="font-display text-2xl text-text">Gerenciar usuários</h1>
        <p className="text-sm text-textMuted">Ordene as colunas e bloqueie contas quando necessário</p>
      </header>

      <Input prefix="🔎" placeholder="Buscar por nome ou e-mail"
        value={query} onChange={(e) => setQuery(e.target.value)} />

      {filtered.length === 0 ? (
        <EmptyState icon="🔍" title="Nenhum resultado"
          description="Nenhum usuário corresponde à busca." />
      ) : (
        <Card padded={false} className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="border-b border-border">
              <tr>
                <Th k="name">Nome</Th>
                <Th k="email" className="hidden sm:table-cell">E-mail</Th>
                <Th k="role">Papel</Th>
                <Th k="habitCount">Hábitos</Th>
                <Th k="status">Status</Th>
                <th className="px-3 py-2" />
              </tr>
            </thead>
            <tbody>
              {filtered.map(({ user, habitCount }) => {
                const isSelf = user.id === currentUser?.id;
                return (
                  <tr key={user.id} className="border-b border-border last:border-0">
                    <td className="px-3 py-2 text-text">{user.name}</td>
                    <td className="px-3 py-2 text-textMuted hidden sm:table-cell">{user.email}</td>
                    <td className="px-3 py-2">
                      <Badge tone={user.role === 'moderator' ? 'accent' : 'neutral'} size="sm">
                        {user.role === 'moderator' ? 'Moderador' : 'Usuário'}
                      </Badge>
                    </td>
                    <td className="px-3 py-2 num-tabular text-text">{habitCount}</td>
                    <td className="px-3 py-2">
                      <Badge tone={user.blocked ? 'danger' : 'primary'} size="sm">
                        {user.blocked ? 'Bloqueado' : 'Ativo'}
                      </Badge>
                    </td>
                    <td className="px-3 py-2 text-right">
                      {user.blocked ? (
                        <Button size="sm" variant="secondary" onClick={() => unblockUser(user.id)}>Desbloquear</Button>
                      ) : (
                        <Button size="sm" variant="ghost" className="text-danger hover:bg-dangerSoft"
                          disabled={isSelf} onClick={() => blockUser(user.id)}>
                          Bloquear
                        </Button>
                      )}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </Card>
      )}
    </div>
  );
}
