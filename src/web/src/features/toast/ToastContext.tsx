import { createContext, useCallback, useContext, useState, type ReactNode } from 'react';
import { ToastView } from '@/components/ui';
import { makeId } from '@/lib/id';

type Tone = 'success' | 'error' | 'info';
type Toast = { id: string; message: string; tone: Tone };

type ToastAPI = {
  show: (message: string, tone?: Tone) => void;
};

const Ctx = createContext<ToastAPI | null>(null);

export function ToastProvider({ children }: { children: ReactNode }) {
  const [toasts, setToasts] = useState<Toast[]>([]);

  const show = useCallback((message: string, tone: Tone = 'success') => {
    const id = makeId();
    setToasts((cur) => [...cur, { id, message, tone }]);
    setTimeout(() => setToasts((cur) => cur.filter((t) => t.id !== id)), 3000);
  }, []);

  return (
    <Ctx.Provider value={{ show }}>
      {children}
      <div className="fixed bottom-20 sm:bottom-6 left-1/2 -translate-x-1/2 z-[60] flex flex-col gap-2 pointer-events-none">
        {toasts.map((t) => (
          <ToastView key={t.id} message={t.message} tone={t.tone} />
        ))}
      </div>
    </Ctx.Provider>
  );
}

export function useToast(): ToastAPI {
  const ctx = useContext(Ctx);
  if (!ctx) throw new Error('useToast must be used within ToastProvider');
  return ctx;
}
