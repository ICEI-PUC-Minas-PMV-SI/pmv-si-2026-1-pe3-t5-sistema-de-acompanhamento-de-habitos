# 3. DOCUMENTO DE ESPECIFICAÇÃO DE REQUISITOS DE SOFTWARE

Este documento detalha a especificação de requisitos do sistema proposto — o SAH (Sistema de Acompanhamento de Hábitos) — contemplando objetivos, escopo, requisitos funcionais e não funcionais, modelagem de casos de uso e diagrama de classes.

## 3.1 Objetivos deste documento

Descrever e especificar as necessidades dos usuários finais que devem ser atendidas pelo projeto SAH – Sistema de Acompanhamento de Hábitos, de modo a orientar as etapas de design, desenvolvimento e testes da aplicação.

## 3.2 Escopo do produto

### 3.2.1 Nome do produto e seus componentes principais
O produto será denominado **SAH – Sistema de Acompanhamento de Hábitos**. Ele será composto pelos seguintes módulos:

- **Módulo de Autenticação:** responsável pelo cadastro, login e recuperação de senha dos usuários.
- **Módulo de Gestão de Hábitos:** responsável pela criação, edição, exclusão e categorização dos hábitos monitorados.
- **Módulo de Check-in Diário:** responsável pelo registro diário de execução dos hábitos e pelo cálculo de sequências (streaks).
- **Módulo de Dashboard e Relatórios:** responsável pela exibição de métricas de progresso, gráficos de frequência e histórico de atividades.
- **Módulo de Notificações:** responsável pelo agendamento e disparo de lembretes configuráveis pelo usuário.

### 3.2.2 Missão do produto

Permitir que usuários registrem, monitorem e acompanhem hábitos pessoais ao longo do tempo, oferecendo feedback visual sobre o progresso e mecanismos de engajamento como sequências de dias consecutivos (streaks) e lembretes configuráveis.

### 3.2.3 Limites do produto
O SAH não fornece nenhuma forma de diagnóstico médico, prescrição de dietas, planos de treino físico ou orientação psicológica. O sistema não realiza integração com dispositivos wearables (smartwatches, pulseiras fitness) nem com aplicativos de saúde de terceiros. O SAH não contempla funcionalidades de rede social, compartilhamento público de progresso ou gamificação com competição entre usuários.

### 3.2.4 Benefícios do produto

| # | Benefício | Valor para o Cliente |
|----|-----------|----------------------|
| 1 | Registro diário rápido de hábitos | Essencial |
| 2 | Visualização de streaks e progresso | Essencial |
| 3 | Lembretes configuráveis pelo usuário | Essencial |
| 4 | Organização de hábitos por categorias | Recomendável |
| 5 | Histórico de registros por período | Recomendável |

## 3.3 Descrição geral do produto

### 3.3.1 Requisitos Funcionais

| Código | Requisito Funcional (Funcionalidade) | Descrição |
|--------|--------------------------------------|-----------|
| RF01 | Cadastrar usuário | O sistema deve permitir que o usuário crie uma conta com e-mail e senha |
| RF02 | Autenticar usuário | O sistema deve permitir login e logout com as credenciais cadastradas |
| RF03 | Gerenciar hábitos | O sistema deve permitir criar, editar, excluir e consultar hábitos |
| RF04 | Registrar conclusão diária | O sistema deve permitir marcar um hábito como concluído no dia atual |
| RF05 | Visualizar streaks | O sistema deve exibir a sequência de dias consecutivos em que o hábito foi concluído |
| RF06 | Configurar lembretes | O sistema deve permitir definir notificações para horários específicos por hábito |
| RF07 | Gerenciar categorias | O sistema deve permitir criar e associar categorias aos hábitos |
| RF08 | Visualizar histórico | O sistema deve exibir o histórico de registros de um hábito por período |
| RF09 | Visualizar progresso geral | O sistema deve exibir um painel com resumo de todos os hábitos do dia (quantos concluídos e pendentes) |
| RF10 | Editar perfil | O sistema deve permitir ao usuário alterar nome e senha da conta |
| RF11 | Recuperar senha | O sistema deve permitir redefinição de senha via e-mail |
| RF12 | Arquivar hábito | O sistema deve permitir arquivar hábitos inativos sem excluí-los, preservando o histórico |

### 3.3.2 Requisitos Não Funcionais

| Código | Requisito Não Funcional (Restrição) |
|--------|--------------------------------------|
| RNF01 | O sistema deve ser uma aplicação web responsiva, acessível via navegador |
| RNF02 | O sistema deve responder a interações do usuário em até 2 segundos |
| RNF03 | O sistema deve armazenar senhas de forma criptografada |
| RNF04 | O sistema deve funcionar de forma responsiva em dispositivos móveis e desktop |
| RNF05 | O sistema deve ser compatível com os navegadores Chrome, Firefox e Edge em suas versões mais recentes |
| RNF06 | O sistema deve sincronizar os dados com o servidor sempre que houver conexão ativa |
| RNF07 | A interface deve seguir diretrizes básicas de acessibilidade (contraste mínimo e tamanho de fonte legível) |
| RNF08 | O sistema deve estar em conformidade com a LGPD, permitindo ao usuário excluir sua conta e todos os seus dados |
| RNF09 | O sistema deve exibir mensagens de erro claras ao usuário em caso de falha de operação |
| RNF10 | O sistema deve realizar backup dos dados automaticamente |
| RNF11 | O código-fonte deve ser mantido em repositório versionado com controle de acesso |
| RNF12 | O sistema deve permitir o uso por múltiplos usuários cadastrados de forma independente e segura |

### 3.3.3 Usuários

| Ator | Descrição |
|------|-----------|
| Usuário | Pessoa cadastrada no sistema responsável pelo gerenciamento de seus próprios hábitos. Possui acesso total às funcionalidades do sistema referentes à sua conta. |

## 3.4 Modelagem do Sistema

### 3.4.1 Diagrama de Casos de Uso

_A ser inserido._

### 3.4.2 Descrições de Casos de Uso

_A ser inserido._

### 3.4.3 Diagrama de Classes

_A ser inserido._

### 3.4.4 Descrições das Classes

_A ser inserido._
