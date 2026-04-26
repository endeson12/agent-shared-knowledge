#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/agent-shared-knowledge"
cd "$REPO"

git pull --rebase || true

NOW="$(date '+%Y-%m-%d %H:%M:%S')"
ISO_NOW="$(date -Is)"
DOC_DIR="sandbox/api-docs"
mkdir -p "$DOC_DIR" team-growth

INDEX_FILE="team-growth/downloaded-tools.md"
STATE_FILE="team-growth/.active-research-index"

SOURCES=(
  "Meta Marketing API|https://developers.facebook.com/docs/marketing-apis/|paid-traffic.md|Meta Ads, campanhas, públicos, criativos e reporting."
  "Instagram Graph API|https://developers.facebook.com/docs/instagram-platform/|organic-traffic.md|Publicação, insights, mídia e presença orgânica no Instagram."
  "TikTok Marketing API|https://business-api.tiktok.com/portal/docs|paid-traffic.md|Campanhas TikTok Ads, relatórios, criativos e catálogo."
  "Google Ads API|https://developers.google.com/google-ads/api/docs/start|paid-traffic.md|Campanhas Google Ads, keyword planning, reporting e automações."
  "WhatsApp Business Platform|https://developers.facebook.com/docs/whatsapp/|api-research.md|Atendimento, notificações aprovadas, funil e automação com consentimento."
  "Shopify Admin API|https://shopify.dev/docs/api/admin|dropshipping.md|Produtos, pedidos, estoque, loja e automações e-commerce."
  "WooCommerce REST API|https://woocommerce.github.io/woocommerce-rest-api-docs/|dropshipping.md|Produtos, pedidos, cupons e automações para lojas WordPress."
  "Stripe API|https://docs.stripe.com/api|infoproducts.md|Checkout, pagamentos, assinaturas e billing."
  "Mercado Pago Developers|https://www.mercadopago.com.br/developers/pt/docs|infoproducts.md|Checkout, pagamentos no Brasil e automações comerciais."
  "Hotmart Developers|https://developers.hotmart.com/|infoproducts.md|Infoprodutos, vendas, assinaturas e webhooks."
  "RD Station Developers|https://developers.rdstation.com/|api-research.md|CRM, leads, automação de marketing e funil."
  "Brevo API|https://developers.brevo.com/|api-research.md|Email marketing, automação, contatos e transacional."
  "Mailchimp Marketing API|https://mailchimp.com/developer/marketing/api/|api-research.md|Listas, campanhas, automação de email e audiência."
  "Google Sheets API|https://developers.google.com/sheets/api/guides/concepts|sdk-research.md|Base simples para CRM, relatórios, funil e operações."
)

idx=0
if [[ -f "$STATE_FILE" ]]; then
  idx="$(cat "$STATE_FILE" 2>/dev/null || echo 0)"
fi
if ! [[ "$idx" =~ ^[0-9]+$ ]]; then idx=0; fi
idx=$((idx % ${#SOURCES[@]}))
NEXT=$(((idx + 1) % ${#SOURCES[@]}))
echo "$NEXT" > "$STATE_FILE"

IFS='|' read -r NAME URL TARGET_FILE PURPOSE <<< "${SOURCES[$idx]}"
SLUG="$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-|-$//g')"
OUT="$DOC_DIR/${SLUG}.html"
TXT="$DOC_DIR/${SLUG}.txt"

HTTP_CODE="000"
if command -v curl >/dev/null 2>&1; then
  HTTP_CODE="$(curl -L --max-time 30 --retry 2 --retry-delay 2 -A 'Shield-Mel-ResearchBot/1.0 (+private sandbox research)' -o "$OUT" -w '%{http_code}' "$URL" 2>/dev/null || echo 000)"
  if [[ -s "$OUT" ]]; then
    python3 - "$OUT" "$TXT" <<'PY'
import re, sys
from html import unescape
src, dst = sys.argv[1], sys.argv[2]
data = open(src, 'rb').read().decode('utf-8', 'ignore')
data = re.sub(r'(?is)<script.*?</script>|<style.*?</style>|<noscript.*?</noscript>', ' ', data)
data = re.sub(r'(?s)<[^>]+>', ' ', data)
data = unescape(data)
data = re.sub(r'\s+', ' ', data).strip()
open(dst, 'w', encoding='utf-8').write(data[:12000] + ('\n' if data else ''))
PY
  fi
fi

SUMMARY="Baixado para análise em sandbox. Revisar documentação oficial, autenticação, permissões, limites, custos, webhooks e riscos antes de qualquer uso real."
if [[ "$HTTP_CODE" != 2* ]]; then
  SUMMARY="Tentativa de download registrou HTTP $HTTP_CODE. Ainda assim manter link oficial para revisão manual/novo teste."
fi

cat >> "team-growth/$TARGET_FILE" <<EOM

---

## Pesquisa ativa — $NOW — $NAME

- Link oficial: $URL
- Finalidade: $PURPOSE
- Status download: HTTP $HTTP_CODE
- Arquivo sandbox: $OUT
- Texto extraído: $TXT
- Uso possível em vendas: criar automações, relatórios, funis, segmentações, integração com CRM/planilhas e geração de campanhas/ideias.
- Autenticação: verificar OAuth/API key/permissões na documentação oficial antes de qualquer teste.
- Riscos: custos, limites de uso, políticas da plataforma, privacidade, LGPD, tokens e ações externas.
- Próximo teste seguro: criar exemplo em sandbox usando dados fake e arquivo .env.example, sem token real.
- Observação: $SUMMARY
EOM

cat >> team-growth/api-research.md <<EOM

---

## API avaliada — $NOW — $NAME

- URL: $URL
- Categoria: $TARGET_FILE
- Propósito: $PURPOSE
- Sandbox: $OUT
- Próxima ação: transformar em checklist de integração segura e possível skill local.
EOM

cat >> team-growth/skill-backlog.md <<EOM

---

## Possível skill — $NOW — $NAME

Criar skill experimental para analisar documentação/uso de **$NAME** e gerar:
- checklist de autenticação;
- casos de uso comercial;
- riscos e limites;
- exemplo com dados falsos;
- plano de integração com aprovação humana para tokens/campanhas/mensagens reais.
EOM

cat >> "$INDEX_FILE" <<EOM
- $ISO_NOW — $NAME — $URL — status HTTP $HTTP_CODE — salvo em $OUT
EOM

cat >> team-growth/sandbox-tests.md <<EOM

---

## Teste sandbox sugerido — $NOW — $NAME

Criar um script local mínimo que não usa token real e apenas valida estrutura de payload, endpoints públicos/documentação e modelo de dados esperado.
EOM

cat >> team-growth/hourly-sync.md <<EOM

---

# Pesquisa ativa executada — $NOW

Fonte estudada: **$NAME**
Link: $URL
Resultado: documentação baixada/registrada em sandbox e backlog atualizado.
EOM

cat >> team-sync/cron-log.md <<EOM
- $NOW — Pesquisa ativa de crescimento executada: $NAME.
EOM

./scripts/scan-secrets.sh

git add .
git commit -m "Active growth research - $NAME - $NOW" || true
git push || true
