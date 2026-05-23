import clsx from 'clsx';
import { Link } from 'react-router-dom';
import { Card, Badge, Icon } from '@/components/ui';
import { computeStreak } from '@/lib/streak';
import { todayKey } from '@/lib/date';
import type { Habit, CheckIn } from '@/features/habits/types';

const FREQ_LABEL = (h: Habit) => {
  if (h.frequency.kind === 'daily') return 'Diariamente';
  if (h.frequency.kind === 'weekdays') {
    const names = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    return h.frequency.days.map((d) => names[d]).join(' · ');
  }
  return `${h.frequency.count}× por semana`;
};

type Props = {
  habit: Habit;
  checkIns: CheckIn[];
  done: boolean;
  onToggle: () => void;
};

export function HabitCard({ habit, checkIns, done, onToggle }: Props) {
  const streak = computeStreak(habit, checkIns, todayKey());

  return (
    <Card className="flex items-center gap-3 hover:shadow-md transition-shadow">
      <button
        type="button"
        onClick={onToggle}
        aria-label={done ? 'Desfazer check-in' : 'Marcar como concluído'}
        className={clsx(
          'w-10 h-10 rounded-full border-2 flex items-center justify-center shrink-0 transition-all',
          done
            ? 'bg-primary border-primary text-surface animate-bounce-in'
            : 'border-borderStrong text-transparent hover:border-primary',
        )}
      >
        ✓
      </button>
      <Link to={`/habitos/${habit.id}`} className="flex-1 min-w-0">
        <div className="flex items-center gap-2">
          <Icon name={habit.icon} size={18} />
          <span className="font-display font-medium text-text truncate">{habit.name}</span>
        </div>
        <div className="flex items-center gap-2 text-xs text-textMuted mt-0.5">
          <span>{FREQ_LABEL(habit)}</span>
          {streak > 0 && (
            <Badge tone="streak" size="sm">🔥 {streak} {streak === 1 ? 'dia' : 'dias'}</Badge>
          )}
        </div>
      </Link>
    </Card>
  );
}
