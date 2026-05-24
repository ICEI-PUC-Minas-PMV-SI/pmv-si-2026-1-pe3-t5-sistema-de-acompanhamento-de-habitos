import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Button, FormField, Input } from '@/components/ui';
import { useAuth } from '@/features/auth/useAuth';
import { useToast } from '@/features/toast/ToastContext';

export function Cadastro() {
  const navigate = useNavigate();
  const { signUp } = useAuth();
  const { show } = useToast();
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitting, setSubmitting] = useState(false);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const next: Record<string, string> = {};
    if (name.trim().length < 2) next.name = 'Mínimo 2 caracteres';
    if (!/^\S+@\S+\.\S+$/.test(email)) next.email = 'E-mail inválido';
    if (password.length < 6) next.password = 'Mínimo 6 caracteres';
    if (confirm !== password) next.confirm = 'As senhas não coincidem';
    setErrors(next);
    if (Object.keys(next).length) return;

    setSubmitting(true);
    const res = await signUp(name.trim(), email, password);
    setSubmitting(false);

    if (res.ok) {
      show('Conta criada com sucesso!');
      navigate('/', { replace: true });
    } else {
      show(res.error, 'error');
    }
  };

  return (
    <form onSubmit={onSubmit} className="space-y-4">
      <header className="text-center mb-2">
        <h1 className="font-display text-2xl text-text">Criar conta</h1>
        <p className="text-sm text-textMuted">Comece a acompanhar seus hábitos hoje</p>
      </header>

      <FormField label="Nome" htmlFor="name" error={errors.name}>
        <Input id="name" value={name} onChange={(e) => setName(e.target.value)}
          invalid={!!errors.name} placeholder="Como devemos te chamar" />
      </FormField>

      <FormField label="E-mail" htmlFor="email" error={errors.email}>
        <Input id="email" type="email" value={email}
          onChange={(e) => setEmail(e.target.value)} invalid={!!errors.email}
          placeholder="seu@email.com" />
      </FormField>

      <FormField label="Senha" htmlFor="password" helper="Mínimo 6 caracteres" error={errors.password}>
        <Input id="password" type="password" value={password}
          onChange={(e) => setPassword(e.target.value)} invalid={!!errors.password} />
      </FormField>

      <FormField label="Confirmar senha" htmlFor="confirm" error={errors.confirm}>
        <Input id="confirm" type="password" value={confirm}
          onChange={(e) => setConfirm(e.target.value)} invalid={!!errors.confirm} />
      </FormField>

      <Button type="submit" fullWidth loading={submitting}>Criar conta</Button>

      <Link to="/login" className="block text-center text-sm text-primary hover:underline">
        Já tenho conta
      </Link>
    </form>
  );
}
