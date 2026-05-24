import { Component, type ReactNode } from 'react';
import { Button } from '@/components/ui';

type Props = { children: ReactNode };
type State = { hasError: boolean };

export class ErrorBoundary extends Component<Props, State> {
  state: State = { hasError: false };

  static getDerivedStateFromError(): State {
    return { hasError: true };
  }

  render() {
    if (!this.state.hasError) return this.props.children;
    return (
      <div className="min-h-screen flex flex-col items-center justify-center bg-bg text-center px-6">
        <div className="text-6xl mb-4">😵</div>
        <h1 className="font-display text-2xl text-text">Algo deu errado</h1>
        <p className="text-sm text-textMuted mt-2 max-w-sm">
          Ocorreu um erro inesperado no protótipo. Recarregue a página para continuar.
        </p>
        <Button className="mt-6" onClick={() => window.location.reload()}>Recarregar</Button>
      </div>
    );
  }
}
