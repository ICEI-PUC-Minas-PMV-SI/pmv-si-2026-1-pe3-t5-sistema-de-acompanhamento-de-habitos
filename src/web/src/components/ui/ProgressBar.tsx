import clsx from 'clsx';

type Props = {
  value: number;
  tone?: 'primary' | 'streak';
  className?: string;
};

const TONE: Record<NonNullable<Props['tone']>, string> = {
  primary: 'bg-primary',
  streak: 'bg-streak',
};

export function ProgressBar({ value, tone = 'primary', className }: Props) {
  const clamped = Math.max(0, Math.min(100, value));
  return (
    <div className={clsx('w-full h-2 bg-surfaceAlt rounded-full overflow-hidden', className)}>
      <div className={clsx('h-full transition-all duration-300', TONE[tone])}
           style={{ width: `${clamped}%` }} />
    </div>
  );
}
