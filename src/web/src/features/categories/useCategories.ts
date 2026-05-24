import { useStore } from '@/features/auth/useAuth';
import { makeId } from '@/lib/id';
import type { Category } from './types';

export function useCategories() {
  const { store, setStore } = useStore();

  const addCategory = (label: string, icon: string): Category => {
    const category: Category = { id: makeId(), label, icon };
    setStore((s) => ({ ...s, categories: [...s.categories, category] }));
    return category;
  };

  const updateCategory = (id: string, patch: Partial<Omit<Category, 'id'>>) => {
    setStore((s) => ({
      ...s,
      categories: s.categories.map((c) => (c.id === id ? { ...c, ...patch } : c)),
    }));
  };

  const deleteCategory = (id: string) => {
    setStore((s) => ({ ...s, categories: s.categories.filter((c) => c.id !== id) }));
  };

  return { categories: store.categories, addCategory, updateCategory, deleteCategory };
}
