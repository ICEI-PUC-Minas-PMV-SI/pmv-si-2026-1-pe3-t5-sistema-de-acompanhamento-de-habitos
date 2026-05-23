import clsx from 'clsx';
import type { ElementType, ReactNode } from 'react';

type Props = {
  as?: ElementType;
  padded?: boolean;
  className?: string;
  children: ReactNode;
  onClick?: () => void;
};

export function Card({ as: Tag = 'div', padded = true, className, children, onClick }: Props) {
  return (
    <Tag
      onClick={onClick}
      className={clsx(
        'bg-surface border border-border rounded-lg shadow-sm',
        padded && 'p-4',
        onClick && 'cursor-pointer hover:shadow-md transition-shadow',
        className,
      )}
    >
      {children}
    </Tag>
  );
}
