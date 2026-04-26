#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/agent-shared-knowledge"
cd "$REPO"

git pull --rebase || true
NOW="$(date '+%Y-%m-%d %H:%M:%S')"
TODAY="$(date '+%Y-%m-%d')"

{
  echo
  echo "---"
  echo
  echo "# Resumo comercial para Endeson — $NOW"
  echo
  echo "## O que foi acumulado pelas rotinas"
  echo
  echo "### Últimos sprints horários"
  grep -n "^## Sprint comercial" team-sync/hourly-growth-sprints.md 2>/dev/null | tail -12 || true
  echo
  echo "### Últimas oportunidades"
  tail -30 team-sync/opportunities.md 2>/dev/null || true
  echo
  echo "### Ideias de conteúdo"
  tail -40 team-sync/content-ideas.md 2>/dev/null || true
  echo
  echo "### Ideias de campanha"
  tail -40 team-sync/campaign-ideas.md 2>/dev/null || true
  echo
  echo "### Ferramentas/APIs para avaliar"
  tail -40 team-sync/tool-watchlist.md 2>/dev/null || true
  tail -40 team-sync/api-watchlist.md 2>/dev/null || true
  echo
  echo "## Próxima ação recomendada"
  echo
  echo "Escolher 1 oferta simples, 1 landing page curta e 3 criativos para testar antes de espalhar energia em muitas frentes."
} >> team-sync/daily-briefing.md

cat >> team-sync/cron-log.md <<EOM
- $NOW — Resumo comercial automático gerado para Endeson.
EOM

./scripts/scan-secrets.sh

git add .
git commit -m "Growth summary - $TODAY" || true
git push || true
