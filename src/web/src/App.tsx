import { useEffect } from 'react';
import { BrowserRouter } from 'react-router-dom';
import { AuthProvider } from '@/features/auth/AuthContext';
import { HabitsProvider } from '@/features/habits/HabitsContext';
import { ToastProvider } from '@/features/toast/ToastContext';
import { AppRoutes } from './routes';
import { resetStore } from '@/lib/storage';

function ResetShortcut() {
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.ctrlKey && e.shiftKey && e.key.toLowerCase() === 'r') {
        e.preventDefault();
        if (confirm('Resetar protótipo para o estado inicial? (apaga login e dados)')) {
          resetStore();
          window.location.reload();
        }
      }
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, []);
  return null;
}

export default function App() {
  return (
    <AuthProvider>
      <HabitsProvider>
        <ToastProvider>
          <BrowserRouter>
            <ResetShortcut />
            <AppRoutes />
          </BrowserRouter>
        </ToastProvider>
      </HabitsProvider>
    </AuthProvider>
  );
}
