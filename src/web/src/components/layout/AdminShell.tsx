import { NavLink, Outlet } from 'react-router-dom';
import clsx from 'clsx';
import { Logo, Button, Badge } from '@/components/ui';
import { useAuth } from '@/features/auth/useAuth';

const ITEMS = [
  { to: '/admin', label: 'Dashboard', icon: '📊', end: true },
  { to: '/admin/usuarios', label: 'Usuários', icon: '👥', end: false },
  { to: '/admin/categorias', label: 'Categorias', icon: '🏷️', end: false },
  { to: '/admin/logs', label: 'Logs', icon: '📜', end: false },
];

function NavItems({ vertical }: { vertical: boolean }) {
  return (
    <>
      {ITEMS.map((item) => (
        <NavLink
          key={item.to}
          to={item.to}
          end={item.end}
          className={({ isActive }) =>
            clsx(
              vertical
                ? 'flex items-center gap-2 px-3 py-2 rounded-md text-sm'
                : 'flex flex-col items-center gap-0.5 py-2 text-xs flex-1',
              isActive
                ? vertical ? 'bg-primarySoft text-primary' : 'text-primary'
                : vertical ? 'text-text hover:bg-surfaceAlt' : 'text-textMuted',
            )
          }
        >
          <span className={vertical ? '' : 'text-lg'}>{item.icon}</span>
          {item.label}
        </NavLink>
      ))}
    </>
  );
}

export function AdminShell() {
  const { currentUser, signOut } = useAuth();
  return (
    <div className="min-h-screen flex bg-bg">
      <aside className="hidden sm:flex flex-col w-60 border-r border-border bg-surface px-4 py-6 sticky top-0 h-screen">
        <div className="mb-1"><Logo size={36} withWordmark /></div>
        <p className="text-xs text-textMuted mb-5">Moderação</p>
        <nav className="flex-1">
          <div className="space-y-1"><NavItems vertical /></div>
        </nav>
        <div className="border-t border-border pt-3 mt-3">
          <Badge tone="accent" size="sm">Moderador</Badge>
          <p className="text-sm text-text truncate mt-1">{currentUser?.name}</p>
          <Button variant="ghost" size="sm" className="mt-2" onClick={signOut}>Sair</Button>
        </div>
      </aside>

      <div className="flex-1 flex flex-col">
        <main className="flex-1 w-full max-w-4xl mx-auto px-4 sm:px-6 py-5 pb-20 sm:pb-6">
          <Outlet />
        </main>
        <nav className="fixed bottom-0 inset-x-0 sm:hidden bg-surface border-t border-border z-40 flex">
          <NavItems vertical={false} />
        </nav>
      </div>
    </div>
  );
}
