import { Outlet } from 'react-router-dom';
import { Sidebar } from './Sidebar';
import { BottomNav } from './BottomNav';

export function AppShell() {
  return (
    <div className="min-h-screen flex bg-bg">
      <Sidebar />
      <div className="flex-1 flex flex-col">
        <main className="flex-1 w-full max-w-2xl mx-auto px-4 sm:px-6 py-5 pb-20 sm:pb-6">
          <Outlet />
        </main>
        <BottomNav />
      </div>
    </div>
  );
}
