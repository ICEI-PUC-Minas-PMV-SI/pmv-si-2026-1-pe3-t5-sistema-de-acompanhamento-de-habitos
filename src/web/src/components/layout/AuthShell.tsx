import { Outlet } from 'react-router-dom';
import { Logo } from '@/components/ui';

export function AuthShell() {
  return (
    <div className="min-h-screen flex flex-col bg-bg">
      <div className="w-full max-w-md mx-auto px-5 py-8 flex flex-col flex-1">
        <div className="flex justify-center mb-6">
          <Logo size={48} withWordmark />
        </div>
        <Outlet />
      </div>
    </div>
  );
}
