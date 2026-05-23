import { BrowserRouter } from 'react-router-dom';
import { AuthProvider } from '@/features/auth/AuthContext';
import { HabitsProvider } from '@/features/habits/HabitsContext';
import { ToastProvider } from '@/features/toast/ToastContext';
import { AppRoutes } from './routes';

export default function App() {
  return (
    <AuthProvider>
      <HabitsProvider>
        <ToastProvider>
          <BrowserRouter>
            <AppRoutes />
          </BrowserRouter>
        </ToastProvider>
      </HabitsProvider>
    </AuthProvider>
  );
}
