# Protótipo Web SAH

Protótipo de alta fidelidade do **Sistema de Acompanhamento de Hábitos** para os testes de usabilidade da Fase 4.

## Pré-requisitos

- Node.js 20 ou superior
- npm 10+

## Rodando localmente

```bash
cd src/web
npm install
npm run dev
```

Abre em `http://localhost:5173`.

## Build estático

```bash
npm run build
npm run preview  # serve o build em http://localhost:4173
```

## Testes

```bash
npm test          # roda unit tests uma vez
npm run test:watch
```

## Credenciais demo

**Usuário final:**
- **E-mail:** `demo@sah.dev`
- **Senha:** `123456`

**Moderadora (painel admin):**
- **E-mail:** `marina@sah.dev`
- **Senha:** `123456`

Ao logar como moderadora, você cai no **painel administrativo** (`/admin`): dashboard com métricas, gestão de usuários (com bloqueio), categorias globais e logs do sistema. Usuários comuns vão para o app de hábitos.

Hábitos, check-ins, categorias, usuários e logs são populados automaticamente na primeira execução.

## Atalho de reset

`Ctrl+Shift+R` (em qualquer tela) → confirma e apaga `localStorage`, recarregando o seed inicial. Útil para moderadores entre sessões de teste.

## Tarefas de teste de usabilidade

| # | Tarefa | Rota inicial | Critério de sucesso |
|---|---|---|---|
| 1 | Criar uma conta | `/login` → "Criar conta nova" | Conta criada e Dashboard alcançado |
| 2 | Sair e entrar novamente | `/` (Sidebar/menu) | Logoff + login com mesmas credenciais |
| 3 | Criar hábito "Beber 2L de água", diário, lembrete 08:00 | `/` → "+ Novo" | Hábito salvo aparece no Dashboard |
| 4 | Marcar "Ler 30 min" como concluído hoje | `/` | Toque na bolinha registra check-in com Toast |
| 5 | Ver maior streak no último mês | `/estatisticas` | Identifica seção "Maiores streaks" |
| 6 | Mudar lembrete de "Meditar" para 07:30 | `/` → toque no card → editar | Salva e Toast confirma |

## Notas técnicas

- **Sem backend.** Toda persistência é em `localStorage` (chave `sah:store:v1`).
- **Senhas em texto puro propositalmente** — protótipo offline para testes; não use credenciais reais.
- **Responsivo:** mobile-first, com Sidebar em desktop e BottomNav em mobile.
- Cores, raios, sombras e tipografia em `src/tokens/sah.ts` (fonte da verdade) e expostos como classes Tailwind via `tailwind.config.ts`.
- **Painel de moderação:** acessível por contas com papel `moderator`. As categorias são globais (geridas no admin) e aparecem no formulário de hábito do usuário. O schema do `localStorage` é versionado (`v2`); ao atualizar, dados antigos são descartados e o seed recarregado.
