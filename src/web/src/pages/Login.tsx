import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Button, FormField, Input, CalloutNote } from '@/components/ui';
import { useAuth } from '@/features/auth/useAuth';
import { useToast } from '@/features/toast/ToastContext';

export function Login() {
  const navigate = useNavigate();
  const { signIn } = useAuth();
  const { show } = useToast();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPwd, setShowPwd] = useState(false);
  const [errors, setErrors] = useState<{ email?: string; password?: string }>({});
  const [submitting, setSubmitting] = useState(false);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const next: typeof errors = {};
    if (!/^\S+@\S+\.\S+$/.test(email)) next.email = 'E-mail inválido';
    if (password.length < 6) next.password = 'Mínimo 6 caracteres';
    setErrors(next);
    if (Object.keys(next).length) return;

    setSubmitting(true);
    const res = await signIn(email, password);
    setSubmitting(false);

    if (res.ok) {
      navigate('/', { replace: true });
    } else {
      show(res.error, 'error');
    }
  };

  return (
    <form onSubmit={onSubmit} className="space-y-4">
      <header className="text-center mb-2">
        <h1 className="font-display text-2xl text-text">Bem-vindo de volta</h1>
        <p className="text-sm text-textMuted">Continue acompanhando seus hábitos</p>
      </header>

      <CalloutNote>Demo: <strong>demo@sah.dev</strong> · senha <strong>123456</strong></CalloutNote>

      <FormField label="E-mail" htmlFor="email" error={errors.email}>
        <Input id="email" type="email" value={email}
          onChange={(e) => setEmail(e.target.value)} invalid={!!errors.email}
          placeholder="seu@email.com" />
      </FormField>

      <FormField label="Senha" htmlFor="password" error={errors.password}>
        <div className="relative">
          <Input id="password" type={showPwd ? 'text' : 'password'} value={password}
            onChange={(e) => setPassword(e.target.value)} invalid={!!errors.password} />
          <button type="button"
            onClick={() => setShowPwd((v) => !v)}
            className="absolute right-3 top-1/2 -translate-y-1/2 text-xs text-textMuted hover:text-text">
            {showPwd ? 'Ocultar' : 'Mostrar'}
          </button>
        </div>
      </FormField>

      <div className="text-right">
        <Link to="/recuperar" className="text-sm text-primary hover:underline">
          Esqueci a senha
        </Link>
      </div>

      <Button type="submit" fullWidth loading={submitting}>Entrar</Button>

      <div className="flex items-center gap-2 text-xs text-textFaint">
        <span className="h-px flex-1 bg-border" /> ou <span className="h-px flex-1 bg-border" />
      </div>

      <Link to="/cadastro" className="block text-center text-sm text-primary hover:underline">
        Criar conta nova
      </Link>
    </form>
  );
}
