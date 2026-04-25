# Plano de Implementação — Equipe MEL + Shield

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task when adding scripts or automation beyond documentation.

**Goal:** Transformar a comunicação MEL + Shield em um sistema operacional de equipe com divisão de tarefas, handoffs, revisão cruzada e execução de projetos comerciais.

**Architecture:** O repositório `agent-shared-knowledge` funciona como barramento assíncrono de coordenação. Cada projeto ganha uma pasta própria em `projects/<slug>/` com intake, plano mestre, backlog, worklogs por agente, handoffs, aprovações e status diário. MEL coordena a execução técnica e Shield atua como memória operacional/revisora/trilha de marketing.

**Tech Stack:** Markdown, Git, cron jobs Hermes/OpenClaw, scripts shell opcionais, Telegram como interface do usuário.

---

## Task 1: Registrar sistema operacional da equipe

**Objective:** Documentar papéis, fluxo, segurança e critérios de sucesso.

**Files:**
- Create: `workflows/mel-shield-team-operating-system.md`

**Steps:**
1. Criar documento com papéis de MEL, Shield e usuário.
2. Definir fluxo: intake → plano mestre → execução paralela → handoff → revisão → aprovação.
3. Definir regras de segurança.
4. Verificar se o arquivo não contém secrets.

**Verification:**

```bash
grep -i "token\|senha\|secret" workflows/mel-shield-team-operating-system.md
```

Expected: apenas referências genéricas de segurança, sem valores reais.

## Task 2: Criar playbook de loja virtual + tráfego pago

**Objective:** Criar modelo reutilizável para divisão de tarefas em projetos comerciais.

**Files:**
- Create: `workflows/ecommerce-paid-traffic-playbook.md`

**Steps:**
1. Definir estrutura padrão de pasta por projeto.
2. Definir checklist da MEL.
3. Definir checklist da Shield.
4. Definir templates de produtos e campanhas.
5. Adicionar regras de aprovação.

**Verification:**

```bash
test -f workflows/ecommerce-paid-traffic-playbook.md && echo OK
```

Expected: `OK`.

## Task 3: Avisar Shield sobre novo modelo

**Objective:** Solicitar que Shield passe a usar o novo sistema de equipe e responda com complementos.

**Files:**
- Modify: `team-sync/inbox-shield.md`

**Steps:**
1. Adicionar mensagem da MEL para Shield com link dos novos arquivos.
2. Pedir revisão e sugestões.
3. Pedir que Shield proponha automações complementares.

**Verification:**

```bash
grep -n "Sistema Operacional de Equipe" team-sync/inbox-shield.md
```

Expected: encontrar a nova mensagem.

## Task 4: Validar repositório

**Objective:** Garantir que os arquivos foram criados sem expor credenciais.

**Files:**
- Inspect: changed files

**Steps:**
1. Rodar `git status --short`.
2. Rodar scan simples de padrões sensíveis nos arquivos novos.
3. Revisar diff.

**Verification:**

```bash
git status --short
git diff -- workflows/mel-shield-team-operating-system.md workflows/ecommerce-paid-traffic-playbook.md team-sync/inbox-shield.md
```

Expected: somente documentação segura.

## Task 5: Commit e push

**Objective:** Sincronizar o novo sistema para Shield consumir.

**Files:**
- Commit changed docs

**Steps:**
1. `git add workflows/mel-shield-team-operating-system.md workflows/ecommerce-paid-traffic-playbook.md docs/plans/mel-shield-team-implementation-plan.md team-sync/inbox-shield.md`
2. `git commit -m "docs: establish MEL Shield team workflow"`
3. `git push origin main`

**Verification:**

```bash
git status --short --branch
```

Expected: branch limpa e alinhada com `origin/main`.
