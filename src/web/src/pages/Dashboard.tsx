import { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { Button, ProgressBar, EmptyState } from '@/components/ui';
import { useAuth } from '@/features/auth/useAuth';
import { useHabits } from '@/features/habits/useHabits';
import { useToast } from '@/features/toast/ToastContext';
import { todayKey, fromDateKey } from '@/lib/date';
import { computeStreak } from '@/lib/streak';
import { HabitCard } from './Dashboard.parts';

const MONTHS = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
  'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];

function greeting(): string {
  const h = new Date().getHours();
  if (h < 12) return 'Bom dia';
  if (h < 18) return 'Boa tarde';
  return 'Boa noite';
}

export function Dashboard() {
  const { currentUser } = useAuth();
  const { habits, checkIns, checkIn, uncheckIn } = useHabits();
  const { show } = useToast();
  const today = todayKey();
  const dateObj = fromDateKey(today);

  const todayHabits = useMemo(
    () => habits.filter((h) => {
      if (h.frequency.kind === 'daily') return true;
      if (h.frequency.kind === 'weekdays') return h.frequency.days.includes(dateObj.getDay());
      return true; // times-per-week aparece sempre
    }),
    [habits, dateObj],
  );

  const doneIds = useMemo(
    () => new Set(checkIns.filter((c) => c.date === today).map((c) => c.habitId)),
    [checkIns, today],
  );

  const completed = todayHabits.filter((h) => doneIds.has(h.id)).length;
  const total = todayHabits.length;
  const pct = total > 0 ? Math.round((completed / total) * 100) : 0;

  const onToggle = (habitId: string) => {
    const done = doneIds.has(habitId);
    if (done) {
      uncheckIn(habitId);
      show('Check-in removido', 'info');
    } else {
      checkIn(habitId);
      // streak recomputado vai ser mostrado no próximo render
      const habit = habits.find((h) => h.id === habitId);
      if (habit) {
        const nextStreak = computeStreak(habit, [...checkIns, { id: 'tmp', habitId, userId: '', date: today, createdAt: '' }], today);
        show(`Check-in registrado · 🔥 ${nextStreak} ${nextStreak === 1 ? 'dia' : 'dias'}`);
      } else {
        show('Check-in registrado');
      }
    }
  };

  return (
    <div className="space-y-5">
      <header className="flex items-start justify-between gap-3">
        <div>
          <h1 className="font-display text-2xl text-text">{greeting()}, {currentUser?.name.split(' ')[0]}</h1>
          <p className="text-sm text-textMuted capitalize">
            Hoje, {dateObj.getDate()} de {MONTHS[dateObj.getMonth()]}
          </p>
        </div>
        <Link to="/habitos/novo" className="hidden sm:block">
          <Button size="sm">+ Novo</Button>
        </Link>
      </header>

      {total > 0 && (
        <section className="space-y-2">
          <ProgressBar value={pct} />
          <p className="text-sm text-textMuted">
            {completed} de {total} hábitos concluídos · {pct}%
          </p>
        </section>
      )}

      {todayHabits.length === 0 ? (
        <EmptyState
          icon="🌱"
          title="Nenhum hábito ainda"
          description="Crie seu primeiro hábito para começar a acompanhar seu progresso."
          action={
            <Link to="/habitos/novo">
              <Button>+ Criar hábito</Button>
            </Link>
          }
        />
      ) : (
        <section className="space-y-2.5">
          {todayHabits.map((habit) => (
            <HabitCard
              key={habit.id}
              habit={habit}
              checkIns={checkIns}
              done={doneIds.has(habit.id)}
              onToggle={() => onToggle(habit.id)}
            />
          ))}
        </section>
      )}

      <Link to="/habitos/novo" className="sm:hidden fixed bottom-20 right-4 z-30">
        <button className="w-14 h-14 rounded-full bg-primary text-surface shadow-lg text-2xl flex items-center justify-center hover:bg-primaryHover">
          +
        </button>
      </Link>
    </div>
  );
}
