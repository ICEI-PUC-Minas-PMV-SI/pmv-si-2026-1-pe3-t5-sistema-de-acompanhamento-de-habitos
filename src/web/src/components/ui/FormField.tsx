import clsx from 'clsx';
import type { ReactNode } from 'react';

type Props = {
  label: string;
  htmlFor?: string;
  helper?: string;
  error?: string;
  children: ReactNode;
  className?: string;
};

export function FormField({ label, htmlFor, helper, error, children, className }: Props) {
  return (
    <div className={clsx('flex flex-col gap-1.5', className)}>
      <label htmlFor={htmlFor} className="text-sm font-medium text-text">
        {label}
      </label>
      {children}
      {error ? (
        <p className="text-xs text-danger">{error}</p>
      ) : helper ? (
        <p className="text-xs text-textMuted">{helper}</p>
      ) : null}
    </div>
  );
}
