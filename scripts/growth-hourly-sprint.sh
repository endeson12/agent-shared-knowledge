#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/agent-shared-knowledge"
cd "$REPO"

git pull --rebase || true
NOW="$(date '+%Y-%m-%d %H:%M:%S')"
ISO_NOW="$(date -Is)"
HOUR="$(date '+%H')"

case $((10#$HOUR % 6)) in
  0)
    THEME="Tráfego pago e criativos vencedores"
    OUTCOME="Listar 3 ângulos de anúncio, 3 promessas testáveis e 1 oferta simples para validação rápida."
    ;;
  1)
    THEME="Produtos prontos, infoprodutos e dinheiro rápido honesto"
    OUTCOME="Mapear 3 ideias de produto/oferta que podem ser vendidas sem estoque e com execução rápida."
    ;;
  2)
    THEME="Sites, landing pages e funis simples"
    OUTCOME="Propor 1 estrutura de página, 1 fluxo de captura e 1 automação de follow-up."
    ;;
  3)
    THEME="Conteúdo orgânico: Reels, Shorts, carrosséis e posts"
    OUTCOME="Criar 5 pautas curtas com gancho, promessa e CTA."
    ;;
  4)
    THEME="Ferramentas, APIs e automações comerciais"
    OUTCOME="Registrar 3 ferramentas/APIs úteis e como poderiam aumentar venda, produção ou velocidade."
    ;;
  *)
    THEME="Playbook de vendas e atendimento"
    OUTCOME="Melhorar scripts de abordagem, objeções, follow-up e fechamento."
    ;;
esac

cat >> team-sync/hourly-growth-sprints.md <<EOM

---

## Sprint comercial — $NOW

**Tema:** $THEME

**Resultado esperado:** $OUTCOME

**Regras:**
- Priorizar ações práticas que geram retorno rápido, sem prometer milagre.
- Separar ideias em: executar agora, testar amanhã, estudar depois.
- Não instalar ferramenta paga, não publicar nada e não usar credenciais sem aprovação.
- Registrar oportunidades concretas em opportunities.md.
- Registrar ferramentas em tool-watchlist.md ou api-watchlist.md.
- Registrar campanhas/conteúdos em campaign-ideas.md e content-ideas.md.

EOM

cat >> team-sync/inbox-mel.md <<EOM

---

## Tarefa horária da Shield para MEL — $NOW

MEL, faça uma rodada focada em **$THEME**.
Entregue algo acionável: $OUTCOME

Procure oportunidades de vendas, marketing digital, tráfego pago, sites, infoprodutos, produtos prontos, conteúdos, publicações, Reels, posts e carrosséis.

EOM

cat >> team-sync/inbox-shield.md <<EOM

---

## Tarefa horária da MEL para Shield — $NOW

Shield, revise e transforme em plano prático o tema **$THEME**.
Resultado esperado: $OUTCOME

Cobre execução, descarte ideias fracas e priorize o que pode gerar aprendizado ou dinheiro rápido com baixo risco.

EOM

cat >> team-sync/opportunities.md <<EOM
- $ISO_NOW — Sprint horário criado: $THEME. Saída esperada: $OUTCOME
EOM

cat >> team-sync/cron-log.md <<EOM
- $NOW — Sprint comercial horário executado: $THEME.
EOM

./scripts/scan-secrets.sh

git add .
git commit -m "Hourly growth sprint - $NOW" || true
git push || true
