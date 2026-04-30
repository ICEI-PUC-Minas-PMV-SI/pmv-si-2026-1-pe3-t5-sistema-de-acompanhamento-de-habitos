# 4. PROJETO DO DESIGN DE INTERAÇÃO

## 4.1 Personas

### Persona 1 — Lucas Ferreira

![Persona Lucas Ferreira](img/persona/Lucas_Ferreira.png)

### Persona 2 — Ricardo Oliveira

![Persona Ricardo Oliveira](img/persona/Ricardo_Oliveira.png)

### Persona 3 — Roberto Alves

![Persona Roberto Alves](img/persona/Roberto_Alves.png)

### Persona 4 — Fernanda Lima

![Persona Fernanda Lima](img/persona/Fernanda_Lima.png)

### Persona 5 — Camila Torres

![Persona Camila Torres](img/persona/Camila_Torres.png)

### Persona 6 — Ana Souza

![Persona Ana Souza](img/persona/Ana_Souza.png)


## 4.2 Mapa de Empatia
Mapa da Empatia é um material utilizado para conhecer melhor o seu cliente. A partir do mapa da empatia é possível detalhar a personalidade do cliente e compreendê-la melhor. O objetivo é obter um nível mais profundo de compreensão de uma persona. A seguir um exemplo de template que pode ser usado para o mapa de empatia. Para cada persona deverá ser apresentado o seu respectivo mapa de empatia. Sugere-se a utilização do template apresentado em https://www.rdstation.com/blog/marketing/mapa-da-empatia/.

### Mapa de Empatia — Lucas Ferreira

![Mapa de Empatia Lucas Ferreira](img/mapa_empatia/Lucas_ferreira.png)

| Dimensão | Conteúdo |
|---|---|
| **Pensa e Sente** | Quer mudar sua rotina mas sente que o dia termina rápido demais. Fica frustrado quando quebra uma sequência que estava construindo. |
| **Vê** | Amigos produtivos nas redes sociais. Conteúdos sobre produtividade e desenvolvimento pessoal. |
| **Ouve** | Podcasts de produtividade. Colegas falando sobre apps de rotina. Conselhos de familiares sobre equilíbrio entre trabalho e vida pessoal. |
| **Fala e Faz** | Começa desafios com entusiasmo. Usa o celular para gerenciar tarefas. Esquece compromissos sem notificação. |
| **Dores** | Sensação de desorganização. Culpa quando abandona um hábito. Falta de visibilidade do próprio progresso ao longo do tempo. |
| **Ganhos** | Satisfação ao ver o streak crescer. Sensação de controle da rotina. Progresso visível ao longo do tempo. |

### Mapa de Empatia — Ricardo Oliveira

| Dimensão | Conteúdo |
|---|---|
| **Pensa e Sente** | Quer recuperar a disposição física, mas sente que o "modo automático" do trabalho consome toda sua energia. Sente saudade da vitalidade que tinha antes da paternidade. |
| **Vê** | Reuniões constantes e planilhas de logística. No tempo livre, vê os filhos cheios de energia enquanto ele se sente exausto no sofá. |
| **Ouve** | Notificações de trabalho o dia todo. A esposa comentando sobre a saúde dele. Conselhos médicos sobre a necessidade de movimentar o corpo e reduzir o estresse. |
| **Fala e Faz** | Diz que "segunda-feira começa a academia", mas acaba priorizando o descanso passivo (TV). Usa o celular intensamente para gerenciar a frota, mas esquece de usá-lo para si mesmo. |
| **Dores** | Dores nas costas por sedentarismo. Culpa por não conseguir brincar com os filhos como gostaria. Frustração por não conseguir terminar uma leitura simples sem dormir. |
| **Ganhos** | Sensação de realização ao fechar o dia com os "checks" de autocuidado. Menos dependência de medicação. Prazer em compartilhar momentos ativos com a família. |

## 4.3 Protótipos das Interfaces

O protótipo de alta fidelidade do Sistema de Acompanhamento de Hábitos (SAH) foi desenvolvido como uma aplicação interativa responsiva, contemplando versões para desktop (1280×820 px) e mobile (360×760 px, moldura estilo iPhone). O protótipo está disponível no arquivo `SAH Prototype _standalone_.html` e é totalmente navegável no navegador, sem dependência de servidor externo.

O protótipo está organizado em três seções, totalizando 13 artboards:

### Seção 1 — Módulo de Autenticação

Concentra os fluxos de entrada no sistema: login, criação de conta e recuperação de senha.

| Artboard | Descrição |
|---|---|
| 01 — Login (desktop) | Tela de autenticação com campos de e-mail e senha, opção "Lembrar-me" e link para recuperação. Exibe mensagem motivacional para engajar o usuário desde o primeiro acesso. |
| 02 — Cadastro (desktop) | Formulário de criação de conta com campos de nome, e-mail e senha. |
| 03 — Recuperar senha (desktop) | Formulário para envio do link de redefinição de senha por e-mail. |
| 04 — Login (mobile) | Versão adaptada da tela de login para dispositivo móvel, exibida dentro da moldura de smartphone. |
| 05 — Estado: link enviado | Tela de confirmação exibida após o envio do e-mail de recuperação, com instrução clara ao usuário. |

### Seção 2 — Painel Administrativo

Representa o espaço de gerenciamento da plataforma para a persona administradora (Marina Costa, moderadora). A navegação entre telas é funcional dentro do próprio protótipo.

| Artboard | Descrição |
|---|---|
| 06 — Dashboard Admin (desktop) | Visão geral da plataforma com indicadores de uso, atividade recente e acesso rápido às seções. |
| 07 — Dashboard Admin (mobile) | Versão do dashboard adaptada para smartphone, mantendo as informações essenciais. |
| 08 — Gerenciamento de Usuários | Listagem de usuários com controles de nível de acesso e bloqueio de conta. |
| 09 — Categorias de Hábitos | Interface para criação, edição e exclusão de categorias de hábitos disponíveis na plataforma. |
| 10 — Logs de Atividade | Painel de auditoria com registros de ações filtráveis por tipo de evento. |

### Seção 3 — Estados do Sistema

Cobre cenários críticos de interface que afetam a percepção de confiabilidade do sistema.

| Artboard | Descrição |
|---|---|
| 11 — Carregando | Estado de carregamento com indicador visual animado, evitando a sensação de travamento. |
| 12 — Nenhum resultado | Estado vazio com ilustração e chamada à ação contextual (ex.: "Configurar categorias"). |
| 13 — Erro global | Tela de erro com mensagem humanizada, indicação de que a equipe foi notificada e opções de retorno. |

### Identidade Visual

O protótipo adota uma paleta de cores quentes e escuras (fundo `#1a1715`, superfícies `#2a2622`) combinada com verde como cor primária e roxo como cor de destaque. A cor de *streak* (sequência de dias) é diferenciada para reforçar o elemento de engajamento central do sistema. O protótipo oferece um painel de ajustes (*TweaksPanel*) que permite customizar cores, densidade de layout (compacto/regular/confortável), raio dos cards e estilo de ilustração (blobs/dots/minimal), demonstrando a flexibilidade do sistema de design.

### Princípios Gestálticos Aplicados

**Proximidade:** Controles relacionados — como os campos de e-mail e senha no login, ou os botões de ação de cada usuário no painel — são agrupados visualmente, reduzindo o esforço cognitivo de mapeamento entre elemento e função.

**Semelhança:** Todos os cards de hábito seguem o mesmo padrão visual (ícone, nome, indicador de streak e botão de check), criando uma linguagem uniforme que o usuário reconhece rapidamente em qualquer tela.

**Continuidade:** A navegação lateral no painel administrativo guia o olhar verticalmente de cima para baixo, seguindo a ordem natural de leitura e hierarquizando as seções do sistema.

**Figura e fundo:** O uso de superfícies levemente mais claras (`surface`) sobre o fundo escuro (`bg`) delimita claramente os cards e painéis, destacando o conteúdo principal sem uso de bordas pesadas.

**Pregnância (boa forma):** Elementos de feedback — como o indicador de streak e os chips de categoria — utilizam formas simples e reconhecíveis (círculos, pílulas), facilitando a leitura rápida do progresso.

### Regras de Ouro de Shneiderman Aplicadas

1. **Consistência:** Cores, tipografia (sistema operacional nativo via `system-ui`), tamanhos de botão e posicionamento de elementos de navegação são mantidos em todas as telas, tanto na versão desktop quanto mobile.

2. **Atalhos para usuários frequentes:** O dashboard exibe os hábitos do dia diretamente na tela inicial, sem que o usuário precise navegar por menus, reduzindo o número de interações para a tarefa mais recorrente.

3. **Feedback informativo:** Cada ação crítica gera resposta visual imediata — o envio do e-mail de recuperação exibe a tela de confirmação (artboard 05); o carregamento de dados exibe o estado *loading* (artboard 11); erros são comunicados com mensagem humanizada (artboard 13).

4. **Conclusão de diálogos:** Os fluxos de cadastro e recuperação de senha possuem telas de encerramento explícitas, comunicando ao usuário que a ação foi concluída com sucesso.

5. **Prevenção e tratamento simples de erros:** Os formulários de autenticação orientam o formato esperado dos campos. A tela de erro global (artboard 13) oferece ações claras de recuperação ("Tentar novamente", "Ir ao início"), evitando que o usuário fique preso em estado de falha.

6. **Reversão fácil de ações:** Ações destrutivas no painel administrativo (bloqueio de usuário, exclusão de categoria) são acompanhadas de confirmação, e o usuário pode desfazê-las enquanto não confirmadas.

7. **Controle e iniciativa do usuário:** O painel de ajustes (*Tweaks*) permite ao administrador personalizar a aparência da interface (cores primária e de destaque, densidade, estilo de ilustração e exibição de streaks), transmitindo sensação de controle sobre o sistema.

8. **Redução da carga de memória de curto prazo:** O menu lateral do painel administrativo exibe ícones acompanhados de rótulos textuais, eliminando a necessidade de memorizar o significado de cada ícone. Os estados de sistema (vazio, erro) repetem o contexto da ação que falhou, para que o usuário não perca o rastreamento da tarefa.

## 4.4 Testes com Protótipos
Nesta seção você deve apresentar os testes realizados com usuários utilizando os protótipos de alta fidelidade desenvolvidos na seção anterior. O objetivo é avaliar a usabilidade, a clareza das informações e a adequação do design às necessidades das personas definidas no projeto.

Cada integrante do grupo deverá aplicar o teste com um usuário distinto, preferencialmente alinhado ao perfil das personas criadas. Devem ser definidas previamente as tarefas que o usuário deverá executar no protótipo (por exemplo: realizar um cadastro, buscar um produto, concluir uma compra).

Durante a aplicação do teste, registre observações sobre comportamentos, dúvidas, erros e comentários feitos pelo usuário, bem como o tempo necessário para a execução de cada tarefa. Ao final, colete o feedback do participante, destacando pontos positivos e aspectos a serem melhorados.

Os resultados obtidos por todos os integrantes devem ser consolidados, apresentando uma análise geral com os principais problemas encontrados, oportunidades de melhoria e as ações previstas para o projeto final. 
