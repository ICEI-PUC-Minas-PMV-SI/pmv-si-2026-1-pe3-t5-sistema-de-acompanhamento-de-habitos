import { NavLink } from 'react-router-dom';
import clsx from 'clsx';

const ITEMS = [
  { to: '/', label: 'Hábitos', icon: '🏠' },
  { to: '/estatisticas', label: 'Estatísticas', icon: '📊' },
];

export function BottomNav() {
  return (
    <nav className="fixed bottom-0 inset-x-0 sm:hidden bg-surface border-t border-border z-40">
      <ul className="flex">
        {ITEMS.map((item) => (
          <li key={item.to} className="flex-1">
            <NavLink
              to={item.to}
              end
              className={({ isActive }) =>
                clsx(
                  'flex flex-col items-center gap-0.5 py-2 text-xs',
                  isActive ? 'text-primary' : 'text-textMuted',
                )
              }
            >
              <span className="text-lg">{item.icon}</span>
              {item.label}
            </NavLink>
          </li>
        ))}
      </ul>
    </nav>
  );
}
