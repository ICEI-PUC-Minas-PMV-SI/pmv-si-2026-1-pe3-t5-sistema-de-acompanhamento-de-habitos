import { Navigate } from 'react-router-dom';
import { useAuth } from './useAuth';
import type { ReactNode } from 'react';

export function RequireModerator({ children }: { children: ReactNode }) {
  const { currentUser } = useAuth();
  if (!currentUser) return <Navigate to="/login" replace />;
  if (currentUser.role !== 'moderator') return <Navigate to="/" replace />;
  return <>{children}</>;
}
