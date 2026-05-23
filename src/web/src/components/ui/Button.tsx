import clsx from 'clsx';
import { Spinner } from './Spinner';
import type { ButtonHTMLAttributes, ReactNode } from 'react';

type Variant = 'primary' | 'secondary' | 'ghost' | 'danger';
type Size = 'sm' | 'md' | 'lg';

type Props = ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: Variant;
  size?: Size;
  loading?: boolean;
  leftIcon?: ReactNode;
  fullWidth?: boolean;
};

const VARIANTS: Record<Variant, string> = {
  primary:   'bg-primary text-surface hover:bg-primaryHover shadow-sm',
  secondary: 'bg-surface text-text border border-border hover:bg-surfaceAlt',
  ghost:     'bg-transparent text-text hover:bg-surfaceAlt',
  danger:    'bg-danger text-surface hover:opacity-90 shadow-sm',
};

const SIZES: Record<Size, string> = {
  sm: 'h-9 px-3 text-sm rounded-sm',
  md: 'h-11 px-4 text-base rounded-md',
  lg: 'h-13 px-6 text-lg rounded-md',
};

export function Button({
  variant = 'primary', size = 'md',
  loading, leftIcon, fullWidth,
  className, children, disabled, ...rest
}: Props) {
  return (
    <button
      {...rest}
      disabled={disabled || loading}
      className={clsx(
        'inline-flex items-center justify-center gap-2 font-display font-medium',
        'transition-colors disabled:opacity-50 disabled:cursor-not-allowed',
        VARIANTS[variant],
        SIZES[size],
        fullWidth && 'w-full',
        className,
      )}
    >
      {loading ? <Spinner size={16} /> : leftIcon}
      {children}
    </button>
  );
}
