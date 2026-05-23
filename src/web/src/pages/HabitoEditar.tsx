import { useState } from 'react';
import { Link, Navigate, useNavigate, useParams } from 'react-router-dom';
import { Button, Modal } from '@/components/ui';
import { HabitForm } from './HabitForm';
import { useHabits } from '@/features/habits/useHabits';
import { useToast } from '@/features/toast/ToastContext';

export function HabitoEditar() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { habits, updateHabit, deleteHabit } = useHabits();
  const { show } = useToast();
  const [confirmingDelete, setConfirmingDelete] = useState(false);

  const habit = habits.find((h) => h.id === id);
  if (!habit) return <Navigate to="/" replace />;

  return (
    <div className="space-y-4">
      <Link to="/" className="text-sm text-primary hover:underline">← Voltar</Link>
      <h1 className="font-display text-2xl text-text">Editar hábito</h1>

      <HabitForm
        initial={habit}
        submitLabel="Salvar"
        onSubmit={(values) => {
          updateHabit(habit.id, values);
          show('Hábito atualizado');
          navigate('/', { replace: true });
        }}
        onDelete={() => setConfirmingDelete(true)}
      />

      <Modal
        open={confirmingDelete}
        onClose={() => setConfirmingDelete(false)}
        title="Excluir hábito?"
        footer={
          <>
            <Button variant="ghost" onClick={() => setConfirmingDelete(false)}>Cancelar</Button>
            <Button variant="danger" onClick={() => {
              deleteHabit(habit.id);
              show('Hábito excluído', 'info');
              navigate('/', { replace: true });
            }}>Excluir</Button>
          </>
        }
      >
        Esta ação não pode ser desfeita. Todos os check-ins associados a "{habit.name}" serão removidos.
      </Modal>
    </div>
  );
}
