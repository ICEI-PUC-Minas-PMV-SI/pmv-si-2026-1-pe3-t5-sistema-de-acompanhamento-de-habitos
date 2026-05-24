import type { ReactNode } from 'react';

export function CalloutNote({ children }: { children: ReactNode }) {
  return (
    <div className="bg-infoSoft border border-info/20 text-info text-sm rounded-md px-3 py-2">
      {children}
    </div>
  );
}
