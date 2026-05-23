import clsx from 'clsx';

type Tone = 'success' | 'error' | 'info';

const TONE: Record<Tone, string> = {
  success: 'bg-primary text-surface',
  error: 'bg-danger text-surface',
  info: 'bg-info text-surface',
};

export function ToastView({ message, tone = 'success' }: { message: string; tone?: Tone }) {
  return (
    <div className={clsx('rounded-md px-4 py-2 shadow-md animate-slide-up text-sm', TONE[tone])}>
      {message}
    </div>
  );
}
