# Smoke test manual

Checklist 1-pager para validar manualmente antes de cada release. Cobre os
fluxos críticos que **não** estão cobertos por testes automatizados (refactor
do AdminShell, guards de rota, settings modal, switch admin↔user, validações
de senha, dark mode, i18n).

Estimativa: 8–10 minutos.

## Pré-requisitos

- Device Android conectado (físico ou emulador).
- `flutter pub get` + `flutter run --release` (ou `make run`).

---

## 1. Boot e autenticação

- [ ] App abre na splash e cai em `/login` (sem sessão).
- [ ] Login com `eduardo@sah.app` / `senha123` cai em `/admin/dashboard` (owner).
- [ ] Tela admin: AppBar com logo central + ícone de gear. BottomNav com 4 abas
      (Dashboard / Usuários / Categorias / Logs).

## 2. Switch admin ↔ usuário

- [ ] Toca gear no AppBar → modal Settings abre.
- [ ] Modal mostra: Tema, Idioma, **Painel admin → Meus hábitos**, Integração
      de e-mail, **Sair**.
- [ ] Toca "Meus hábitos" → vai pra `/onboarding` (primeiro acesso) ou
      `/app/today` (já completou).
- [ ] Completa/pula onboarding. Aterra em `/app/today` com saudação por nome
      ("Bom dia, Eduardo!" / "Boa tarde, …" / "Boa noite, …").
- [ ] AppBar agora tem gear; BottomNav: Hoje / Hábitos / Histórico / Perfil.
- [ ] Toca gear → modal mostra: Gerenciar categorias, Tema, Idioma, Backup,
      Testar notificação, **Meus hábitos → Painel admin**.
- [ ] Toca "Painel admin" → volta pra `/admin/dashboard`.

## 3. Hábitos + categorias (fluxo do user)

- [ ] Em `/admin` → Settings → Painel admin → "Categorias" → criar categoria
      pessoal "Estudo" cor verde.
- [ ] Toca "Meus hábitos" no modal → vai pra `/app/today`.
- [ ] Aba Hábitos → "Novo hábito" → "Criar do zero" → preenche nome "Ler",
      categoria **Estudo já aparece sem reabrir o app** ✅ (CategoriesBus
      funcionando).
- [ ] Cria com frequência seg-qua-sex.
- [ ] Volta pra Hoje → vê o hábito listado (se hoje for seg/qua/sex).
- [ ] Marca check-in → toast/animação. Streak começa em 1.
- [ ] Aba Histórico → vê o check-in no heatmap + métricas (Check-ins: 1, etc.).

## 4. Validações de senha

- [ ] Perfil → "Alterar senha" → senha atual = nova → erro inline vermelho
      "A nova senha não pode ser igual à atual".
- [ ] Mesmo teste com nova ≠ atual mas com menos de 6 caracteres → erro
      "deve ter no mínimo 6 caracteres".
- [ ] Confirmação diferente → erro "As senhas não coincidem".
- [ ] Tudo correto → snackbar "Senha alterada com sucesso!"

## 5. Logs admin

- [ ] Volta pro Painel admin → aba Logs.
- [ ] Lista mostra os eventos das ações acima (login, criação de categoria,
      criação de hábito, check-in implicitamente, alteração de senha).
- [ ] Cada item exibe e-mail (não só nome) + timestamp com segundos.
- [ ] Toca em qualquer log → modal de detalhes abre com:
      - Tipo (badge colorido)
      - Quando (data + hora com segundos)
      - Evento (descrição completa)
      - Usuário · E-mail · ID do usuário
      - Rota / IP / Plataforma
      - Metadados (se houver)
      - ID do log (copiável)

## 6. Dark mode

- [ ] Em qualquer área → Settings → Tema → Escuro.
- [ ] **Todas as telas** mudam imediatamente (não só a atual). Especial atenção:
      - Dashboard admin
      - Usuários
      - Categorias (admin e user)
      - Logs
      - Histórico
- [ ] Voltar pra Sistema → segue o tema do device.

## 7. i18n

- [ ] Settings → Idioma → English. UI toda muda para inglês imediatamente.
- [ ] Cria um hábito agora ("Read 20 pages") — texto do hábito é gravado em
      inglês.
- [ ] Settings → Idioma → Português. UI volta a PT; o hábito "Read 20 pages"
      **permanece em inglês** (gravado no idioma do momento da criação) — esse
      é o comportamento esperado.

## 8. Logout

- [ ] Settings → "Sair" (em área admin) → dialog de confirmação → confirma →
      volta pra `/login`.
- [ ] Login novamente — sessão restaurada.

## 9. Backup

- [ ] Em área de hábitos: Settings → Backup → "Exportar dados" → share sheet
      abre com o JSON.
- [ ] (Opcional) Em outro device/conta: Importar → confirma dialog destrutivo
      → dados restaurados.

## 10. Discord webhook (se `.env.json` configurado)

- [ ] Após login/criação de hábito, conferir no canal do Discord que chegaram
      embeds com title + cor + fields (Usuário, Rota, IP, Plataforma).
- [ ] Embed do login específico inclui o e-mail entre `<>` no description.

---

## Critério de aprovação

Todos os itens marcados. Qualquer falha = bug bloqueante.

## Quando NÃO executar

- Mudanças puramente em README/docs.
- Hotfix em uma string isolada.

Em qualquer mudança que toque shells, guards, modais globais (settings),
controllers, repositórios, ou tema → **rodar smoke test**.
