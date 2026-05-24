import { Link, useNavigate } from 'react-router-dom';
import { HabitForm } from './HabitForm';
import { useHabits } from '@/features/habits/useHabits';
import { useToast } from '@/features/toast/ToastContext';

export function HabitoNovo() {
  const navigate = useNavigate();
  const { addHabit } = useHabits();
  const { show } = useToast();

  return (
    <div className="space-y-4">
      <Link to="/" className="text-sm text-primary hover:underline">← Voltar</Link>
      <h1 className="font-display text-2xl text-text">Novo hábito</h1>
      <HabitForm
        submitLabel="Criar hábito"
        onSubmit={(values) => {
          addHabit(values);
          show('Hábito criado!');
          navigate('/', { replace: true });
        }}
      />
    </div>
  );
}
