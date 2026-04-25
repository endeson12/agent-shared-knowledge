#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/agent-shared-knowledge"
cd "$REPO"

git pull --rebase || true
NOW="$(date '+%Y-%m-%d %H:%M:%S')"

cat >> team-sync/daily-briefing.md <<EOM

---

# Briefing Diário — $NOW

## Foco do dia

- Vendas
- Marketing digital
- Conteúdo orgânico
- Tráfego pago
- Infoprodutos
- Dropshipping
- Automações comerciais
- APIs e integrações

## Checklist para Shield e MEL

- [ ] Revisar novas oportunidades em team-sync/opportunities.md
- [ ] Revisar propostas em team-sync/skill-proposals.md
- [ ] Atualizar team-sync/marketing-intelligence.md
- [ ] Atualizar team-sync/sales-playbook.md
- [ ] Atualizar team-sync/content-ideas.md
- [ ] Atualizar team-sync/campaign-ideas.md
- [ ] Registrar pendências críticas em team-sync/pending-user-approval.md
- [ ] Garantir que nenhum secret foi commitado

## Pergunta estratégica do dia

Qual ação prática pode ajudar o usuário a vender mais, automatizar melhor ou produzir conteúdo com mais consistência?

EOM

cat >> team-sync/cron-log.md <<EOM
- $NOW — Revisão diária da equipe criada.
EOM

./scripts/scan-secrets.sh

git add .
git commit -m "Daily team review - $NOW" || true
git push || true
