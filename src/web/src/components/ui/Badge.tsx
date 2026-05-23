import clsx from 'clsx';
import type { ReactNode } from 'react';

type Tone = 'primary' | 'streak' | 'accent' | 'danger' | 'neutral';
type Size = 'sm' | 'md';

const TONES: Record<Tone, string> = {
  primary: 'bg-primarySoft text-primary',
  streak:  'bg-streakSoft text-streak',
  accent:  'bg-accentSoft text-accent',
  danger:  'bg-dangerSoft text-danger',
  neutral: 'bg-surfaceAlt text-textMuted',
};

const SIZES: Record<Size, string> = {
  sm: 'text-xs px-2 py-0.5',
  md: 'text-sm px-2.5 py-1',
};

export function Badge({
  tone = 'neutral', size = 'sm', children,
}: { tone?: Tone; size?: Size; children: ReactNode }) {
  return (
    <span className={clsx('inline-flex items-center gap-1 rounded-full font-medium', TONES[tone], SIZES[size])}>
      {children}
    </span>
  );
}
