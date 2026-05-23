import type { ReactNode } from 'react';

type Props = {
  icon?: ReactNode;
  title: string;
  description?: string;
  action?: ReactNode;
};

export function EmptyState({ icon, title, description, action }: Props) {
  return (
    <div className="flex flex-col items-center text-center py-12 px-4">
      {icon && <div className="text-5xl mb-3">{icon}</div>}
      <h3 className="font-display text-lg text-text">{title}</h3>
      {description && <p className="text-sm text-textMuted mt-1 max-w-sm">{description}</p>}
      {action && <div className="mt-4">{action}</div>}
    </div>
  );
}
