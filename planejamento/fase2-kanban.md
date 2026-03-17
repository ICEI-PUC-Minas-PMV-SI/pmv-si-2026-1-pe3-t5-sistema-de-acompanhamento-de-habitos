# Plano de Execução — Fase 2: Especificação de Requisitos

**Prazo de entrega:** 05 de abril de 2026
**Integrantes:** 6 pessoas
**Ferramenta de acompanhamento:** GitHub Projects (Kanban)

---

## Estrutura do Kanban

**Colunas:**
```
Backlog → A Fazer → Em Progresso → Em Revisão → Concluído
```

**Labels:**
- `rf` — requisito funcional
- `rnf` — requisito não-funcional
- `casos-de-uso`
- `diagrama-classes`
- `documentação`
- `revisão`

---

## Distribuição de Responsabilidades

| Pessoa | Responsabilidade principal | Contribuição comum |
|--------|---------------------------|-------------------|
| P1 | Item 1 — Introdução e visão geral do documento | 2 RF + 2 RNF |
| P2 | Item 2 — Compilar e escrever tabela de RF | 2 RF + 2 RNF |
| P3 | Item 3 — Compilar e escrever tabela de RNF | 2 RF + 2 RNF |
| P4 | Item 4 — Diagrama de casos de uso (draw.io) | 2 RF + 2 RNF |
| P5 | Item 4 — Descrições textuais dos casos de uso | 2 RF + 2 RNF |
| P6 | Item 5 — Diagrama de classes (draw.io) | 2 RF + 2 RNF |

> **Contribuição comum:** cada integrante sugere 2 RF (para P2) e 2 RNF (para P3), totalizando 12 RF e 12 RNF no documento final.

---

## Cards por Pessoa

### P1 — Introdução e Visão Geral
- [ ] Escrever seção 3.1 — Objetivos do documento
- [ ] Escrever seção 3.2 — Escopo (nome, missão, limites, benefícios)

### P2 — Requisitos Funcionais
- [ ] Coletar sugestões de RF de todos os integrantes (até 21/03)
- [ ] Consolidar e escrever tabela de RF no `especificacao.md`

### P3 — Requisitos Não-Funcionais
- [ ] Coletar sugestões de RNF de todos os integrantes (até 21/03)
- [ ] Consolidar e escrever tabela de RNF no `especificacao.md`

### P4 — Diagrama de Casos de Uso
- [ ] Levantar atores do sistema com P5 (até 22/03)
- [ ] Criar diagrama no draw.io e exportar imagem
- [ ] Inserir diagrama no `especificacao.md`

### P5 — Descrições dos Casos de Uso
- [ ] Alinhar casos de uso com P4 (até 22/03)
- [ ] Escrever descrição textual de cada caso de uso (fluxo principal + alternativo)
- [ ] Inserir descrições no `especificacao.md`

### P6 — Diagrama de Classes
- [ ] Aguardar definição dos casos de uso com P4/P5 (até 26/03)
- [ ] Criar diagrama de classes no draw.io e exportar imagem
- [ ] Inserir diagrama + tabela de descrição das classes no `especificacao.md`

---

## Cronograma

| Período | Atividades |
|---------|-----------|
| **16–21 mar** | Todos enviam sugestões de RF e RNF. P1 escreve introdução. P4 e P5 levantam atores e casos de uso. |
| **22–26 mar** | P2 consolida RF. P3 consolida RNF. P4 cria diagrama de casos de uso. P5 escreve descrições. |
| **27–31 mar** | P6 cria diagrama de classes. Revisão cruzada entre todos. |
| **01–03 abr** | Ajustes finais, revisão do documento completo, merge no repositório. |
| **04 abr** | Buffer — apenas correções críticas. |
| **05 abr** | Entrega. |

---

## Regras de Colaboração

1. Sugestões de RF e RNF devem chegar a P2 e P3 até **21 de março** — não bloquear a consolidação.
2. P6 só inicia o diagrama de classes após P4/P5 finalizarem os casos de uso (prazo interno: **26 de março**).
3. Cada card no GitHub Projects deve ter **assignee** e **prazo** definidos.
4. Todo PR deve ter revisão de ao menos **1 outro integrante** antes do merge.
