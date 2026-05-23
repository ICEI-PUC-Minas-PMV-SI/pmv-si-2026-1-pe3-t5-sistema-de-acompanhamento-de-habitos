import { NavLink } from 'react-router-dom';
import clsx from 'clsx';
import { Logo, Button } from '@/components/ui';
import { useAuth } from '@/features/auth/useAuth';

const ITEMS = [
  { to: '/', label: 'Hábitos', icon: '🏠' },
  { to: '/estatisticas', label: 'Estatísticas', icon: '📊' },
];

export function Sidebar() {
  const { currentUser, signOut } = useAuth();
  return (
    <aside className="hidden sm:flex flex-col w-60 border-r border-border bg-surface px-4 py-6 sticky top-0 h-screen">
      <div className="mb-6"><Logo size={36} withWordmark /></div>
      <nav className="flex-1">
        <ul className="space-y-1">
          {ITEMS.map((item) => (
            <li key={item.to}>
              <NavLink
                to={item.to}
                end
                className={({ isActive }) =>
                  clsx(
                    'flex items-center gap-2 px-3 py-2 rounded-md text-sm',
                    isActive ? 'bg-primarySoft text-primary' : 'text-text hover:bg-surfaceAlt',
                  )
                }
              >
                <span>{item.icon}</span>{item.label}
              </NavLink>
            </li>
          ))}
        </ul>
      </nav>
      <div className="border-t border-border pt-3 mt-3">
        <p className="text-xs text-textMuted">Sessão</p>
        <p className="text-sm text-text truncate">{currentUser?.name}</p>
        <Button variant="ghost" size="sm" className="mt-2" onClick={signOut}>Sair</Button>
      </div>
    </aside>
  );
}
