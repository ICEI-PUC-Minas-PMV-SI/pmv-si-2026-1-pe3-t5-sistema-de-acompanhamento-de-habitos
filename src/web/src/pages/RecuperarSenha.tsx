import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Button, FormField, Input } from '@/components/ui';

export function RecuperarSenha() {
  const [email, setEmail] = useState('');
  const [submitted, setSubmitted] = useState(false);
  const [error, setError] = useState<string>();

  const onSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!/^\S+@\S+\.\S+$/.test(email)) { setError('E-mail inválido'); return; }
    setError(undefined);
    setSubmitted(true);
  };

  if (submitted) {
    return (
      <div className="text-center space-y-3">
        <div className="text-5xl">📧</div>
        <h1 className="font-display text-2xl text-text">Verifique seu e-mail</h1>
        <p className="text-sm text-textMuted">
          Enviamos instruções para <strong>{email}</strong>.
        </p>
        <Link to="/login" className="block text-sm text-primary hover:underline pt-4">
          Voltar para login
        </Link>
      </div>
    );
  }

  return (
    <form onSubmit={onSubmit} className="space-y-4">
      <header className="text-center mb-2">
        <h1 className="font-display text-2xl text-text">Esqueci a senha</h1>
        <p className="text-sm text-textMuted">Informe seu e-mail para receber instruções</p>
      </header>

      <FormField label="E-mail" htmlFor="email" error={error}>
        <Input id="email" type="email" value={email}
          onChange={(e) => setEmail(e.target.value)} invalid={!!error}
          placeholder="seu@email.com" />
      </FormField>

      <Button type="submit" fullWidth>Enviar instruções</Button>

      <Link to="/login" className="block text-center text-sm text-primary hover:underline">
        Voltar para login
      </Link>
    </form>
  );
}
