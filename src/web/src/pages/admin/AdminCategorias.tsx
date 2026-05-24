import { useState } from 'react';
import clsx from 'clsx';
import { Card, Button, Modal, Input, FormField, EmptyState } from '@/components/ui';
import { useCategories } from '@/features/categories/useCategories';
import type { Category } from '@/features/categories/types';

const ICONS = ['🩺', '📚', '🏃', '📖', '🧘', '🎯', '💧', '💪', '🌱', '🍎', '💻', '🛌'];

export function AdminCategorias() {
  const { categories, addCategory, updateCategory, deleteCategory } = useCategories();
  const [editing, setEditing] = useState<Category | 'new' | null>(null);
  const [deleting, setDeleting] = useState<Category | null>(null);
  const [label, setLabel] = useState('');
  const [icon, setIcon] = useState(ICONS[0]);
  const [error, setError] = useState<string>();

  const openNew = () => { setEditing('new'); setLabel(''); setIcon(ICONS[0]); setError(undefined); };
  const openEdit = (c: Category) => { setEditing(c); setLabel(c.label); setIcon(c.icon); setError(undefined); };
  const close = () => setEditing(null);

  const save = () => {
    if (label.trim().length < 2) { setError('Mínimo 2 caracteres'); return; }
    if (editing === 'new') addCategory(label.trim(), icon);
    else if (editing) updateCategory(editing.id, { label: label.trim(), icon });
    close();
  };

  return (
    <div className="space-y-4">
      <header className="flex items-center justify-between gap-3">
        <div>
          <h1 className="font-display text-2xl text-text">Categorias globais</h1>
          <p className="text-sm text-textMuted">Disponíveis para todos os usuários ao criar hábitos</p>
        </div>
        <Button size="sm" onClick={openNew}>+ Nova</Button>
      </header>

      {categories.length === 0 ? (
        <EmptyState icon="🏷️" title="Sem categorias"
          description="Crie a primeira categoria global."
          action={<Button onClick={openNew}>+ Nova categoria</Button>} />
      ) : (
        <ul className="space-y-2">
          {categories.map((c) => (
            <li key={c.id}>
              <Card className="flex items-center gap-3">
                <span className="text-xl">{c.icon}</span>
                <span className="flex-1 font-medium text-text">{c.label}</span>
                <Button size="sm" variant="ghost" onClick={() => openEdit(c)}>Editar</Button>
                <Button size="sm" variant="ghost" className="text-danger hover:bg-dangerSoft"
                  onClick={() => setDeleting(c)}>Excluir</Button>
              </Card>
            </li>
          ))}
        </ul>
      )}

      <Modal
        open={editing !== null}
        onClose={close}
        title={editing === 'new' ? 'Nova categoria' : 'Editar categoria'}
        footer={
          <>
            <Button variant="ghost" onClick={close}>Cancelar</Button>
            <Button onClick={save}>Salvar</Button>
          </>
        }
      >
        <div className="space-y-4">
          <FormField label="Nome" htmlFor="cat-label" error={error}>
            <Input id="cat-label" value={label} onChange={(e) => setLabel(e.target.value)}
              invalid={!!error} placeholder="Ex: Finanças" />
          </FormField>
          <FormField label="Ícone">
            <div className="flex gap-2 flex-wrap">
              {ICONS.map((i) => (
                <button key={i} type="button" onClick={() => setIcon(i)}
                  className={clsx('w-10 h-10 rounded-md border text-xl',
                    icon === i ? 'border-primary bg-primarySoft' : 'border-border')}>
                  {i}
                </button>
              ))}
            </div>
          </FormField>
        </div>
      </Modal>

      <Modal
        open={deleting !== null}
        onClose={() => setDeleting(null)}
        title="Excluir categoria?"
        footer={
          <>
            <Button variant="ghost" onClick={() => setDeleting(null)}>Cancelar</Button>
            <Button variant="danger" onClick={() => { if (deleting) deleteCategory(deleting.id); setDeleting(null); }}>
              Excluir
            </Button>
          </>
        }
      >
        Hábitos que usam "{deleting?.label}" podem ficar sem categoria. Esta ação não pode ser desfeita.
      </Modal>
    </div>
  );
}
