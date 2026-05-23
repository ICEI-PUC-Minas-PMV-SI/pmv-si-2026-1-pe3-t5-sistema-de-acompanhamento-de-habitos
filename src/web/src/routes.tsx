import { Routes, Route, Navigate } from 'react-router-dom';
import { AuthShell } from '@/components/layout/AuthShell';
import { AppShell } from '@/components/layout/AppShell';
import { RequireAuth } from '@/features/auth/RequireAuth';
import { PublicOnly } from '@/features/auth/PublicOnly';
import { Login } from '@/pages/Login';
import { Cadastro } from '@/pages/Cadastro';
import { RecuperarSenha } from '@/pages/RecuperarSenha';
import { Dashboard } from '@/pages/Dashboard';
import { HabitoNovo } from '@/pages/HabitoNovo';
import { HabitoEditar } from '@/pages/HabitoEditar';
import { Estatisticas } from '@/pages/Estatisticas';

export function AppRoutes() {
  return (
    <Routes>
      <Route element={<AuthShell />}>
        <Route path="/login"     element={<PublicOnly><Login /></PublicOnly>} />
        <Route path="/cadastro"  element={<PublicOnly><Cadastro /></PublicOnly>} />
        <Route path="/recuperar" element={<PublicOnly><RecuperarSenha /></PublicOnly>} />
      </Route>
      <Route element={<RequireAuth><AppShell /></RequireAuth>}>
        <Route path="/"             element={<Dashboard />} />
        <Route path="/habitos/novo" element={<HabitoNovo />} />
        <Route path="/habitos/:id"  element={<HabitoEditar />} />
        <Route path="/estatisticas" element={<Estatisticas />} />
      </Route>
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
