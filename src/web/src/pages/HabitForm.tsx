import { useState } from 'react';
import { Button, FormField, Input, Select, Switch } from '@/components/ui';
import { HABIT_CATEGORIES } from '@/features/habits/types';
import type { Habit, HabitFrequency } from '@/features/habits/types';
import clsx from 'clsx';

const WEEKDAYS = [
  { d: 0, label: 'D' }, { d: 1, label: 'S' }, { d: 2, label: 'T' },
  { d: 3, label: 'Q' }, { d: 4, label: 'Q' }, { d: 5, label: 'S' }, { d: 6, label: 'S' },
];

const COLORS = ['#4A7C59', '#6B5B95', '#C89B3C', '#B8544A', '#5B7FA8'];
const ICONS = ['💧', '📖', '🏃', '🧘', '💻', '🍎', '🎯', '🌱', '💪', '🛌'];

export type HabitFormValues = Omit<Habit, 'id' | 'userId' | 'createdAt' | 'archivedAt'>;

type Props = {
  initial?: Partial<HabitFormValues>;
  onSubmit: (values: HabitFormValues) => void;
  onDelete?: () => void;
  submitLabel: string;
};

export function HabitForm({ initial, onSubmit, onDelete, submitLabel }: Props) {
  const [name, setName] = useState(initial?.name ?? '');
  const [category, setCategory] = useState(initial?.category ?? 'saude');
  const [freqKind, setFreqKind] = useState<HabitFrequency['kind']>(initial?.frequency?.kind ?? 'daily');
  const [weekdays, setWeekdays] = useState<number[]>(
    initial?.frequency?.kind === 'weekdays' ? initial.frequency.days : [1, 2, 3, 4, 5],
  );
  const [timesPerWeek, setTimesPerWeek] = useState<number>(
    initial?.frequency?.kind === 'times-per-week' ? initial.frequency.count : 3,
  );
  const [color, setColor] = useState(initial?.color ?? COLORS[0]);
  const [icon, setIcon] = useState(initial?.icon ?? ICONS[0]);
  const [reminderTime, setReminderTime] = useState(initial?.reminderTime ?? '08:00');
  const [notifications, setNotifications] = useState(initial?.notificationsEnabled ?? true);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const toggleWeekday = (d: number) => {
    setWeekdays((cur) => cur.includes(d) ? cur.filter((x) => x !== d) : [...cur, d].sort());
  };

  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    const next: Record<string, string> = {};
    if (name.trim().length < 3) next.name = 'Mínimo 3 caracteres';
    if (freqKind === 'weekdays' && weekdays.length === 0) next.frequency = 'Selecione ao menos 1 dia';
    setErrors(next);
    if (Object.keys(next).length) return;

    let frequency: HabitFrequency;
    if (freqKind === 'daily') frequency = { kind: 'daily' };
    else if (freqKind === 'weekdays') frequency = { kind: 'weekdays', days: weekdays };
    else frequency = { kind: 'times-per-week', count: timesPerWeek };

    onSubmit({
      name: name.trim(), category, frequency,
      reminderTime, notificationsEnabled: notifications,
      color, icon,
    });
  };

  return (
    <form onSubmit={submit} className="space-y-5">
      <FormField label="Nome do hábito" htmlFor="name" error={errors.name}>
        <Input id="name" value={name} onChange={(e) => setName(e.target.value)}
          invalid={!!errors.name} placeholder="Ex: Beber 2L de água" />
      </FormField>

      <FormField label="Categoria" htmlFor="category">
        <Select id="category" value={category}
          onChange={(e) => setCategory(e.target.value as typeof category)}
          options={HABIT_CATEGORIES.map((c) => ({ value: c.value, label: c.label }))} />
      </FormField>

      <FormField label="Frequência" error={errors.frequency}>
        <div className="space-y-3">
          <div className="flex gap-2 flex-wrap">
            {(['daily', 'weekdays', 'times-per-week'] as const).map((k) => (
              <label key={k} className={clsx(
                'px-3 py-1.5 rounded-full text-sm cursor-pointer border',
                freqKind === k ? 'bg-primarySoft border-primary text-primary' : 'border-border text-textMuted',
              )}>
                <input type="radio" name="freq" className="sr-only"
                  checked={freqKind === k} onChange={() => setFreqKind(k)} />
                {k === 'daily' ? 'Todos os dias' : k === 'weekdays' ? 'Dias da semana' : 'X vezes por semana'}
              </label>
            ))}
          </div>

          {freqKind === 'weekdays' && (
            <div className="flex gap-1.5">
              {WEEKDAYS.map((w) => (
                <button key={w.d} type="button" onClick={() => toggleWeekday(w.d)}
                  className={clsx(
                    'w-9 h-9 rounded-full text-sm font-medium border',
                    weekdays.includes(w.d)
                      ? 'bg-primary text-surface border-primary'
                      : 'border-border text-textMuted hover:border-primary',
                  )}>
                  {w.label}
                </button>
              ))}
            </div>
          )}

          {freqKind === 'times-per-week' && (
            <div className="flex items-center gap-3">
              <button type="button" onClick={() => setTimesPerWeek((v) => Math.max(1, v - 1))}
                className="w-9 h-9 rounded-full border border-border text-text">−</button>
              <span className="text-lg font-display num-tabular">{timesPerWeek}</span>
              <button type="button" onClick={() => setTimesPerWeek((v) => Math.min(7, v + 1))}
                className="w-9 h-9 rounded-full border border-border text-text">+</button>
              <span className="text-sm text-textMuted">vezes por semana</span>
            </div>
          )}
        </div>
      </FormField>

      <FormField label="Cor">
        <div className="flex gap-2">
          {COLORS.map((c) => (
            <button key={c} type="button" onClick={() => setColor(c)}
              aria-label={`Cor ${c}`}
              className={clsx('w-8 h-8 rounded-full border-2', color === c ? 'border-text' : 'border-transparent')}
              style={{ background: c }} />
          ))}
        </div>
      </FormField>

      <FormField label="Ícone">
        <div className="flex gap-2 flex-wrap">
          {ICONS.map((i) => (
            <button key={i} type="button" onClick={() => setIcon(i)}
              className={clsx(
                'w-10 h-10 rounded-md border text-xl',
                icon === i ? 'border-primary bg-primarySoft' : 'border-border',
              )}>
              {i}
            </button>
          ))}
        </div>
      </FormField>

      <FormField label="Horário do lembrete" htmlFor="time">
        <Input id="time" type="time" value={reminderTime}
          onChange={(e) => setReminderTime(e.target.value)} />
      </FormField>

      <div className="flex items-center justify-between">
        <span className="text-sm text-text">Receber notificações</span>
        <Switch checked={notifications} onChange={setNotifications} />
      </div>

      <div className="flex gap-2 pt-2">
        <Button type="submit" fullWidth>{submitLabel}</Button>
      </div>

      {onDelete && (
        <Button type="button" variant="ghost" fullWidth className="text-danger hover:bg-dangerSoft"
          onClick={onDelete}>
          Excluir hábito
        </Button>
      )}
    </form>
  );
}
