#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/agent-shared-knowledge"
cd "$REPO"

# Sincronização tolerante: não travar a rotina se rede/Git remoto estiverem temporariamente indisponíveis.
git pull --rebase || true

NOW="$(date '+%Y-%m-%d %H:%M:%S')"
ISO_NOW="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

mkdir -p team-growth sandbox/downloaded-repos sandbox/api-docs sandbox/sdk-tests sandbox/skill-tests

touch team-growth/hourly-sync.md \
  team-growth/marketing-research.md \
  team-growth/paid-traffic.md \
  team-growth/organic-traffic.md \
  team-growth/infoproducts.md \
  team-growth/dropshipping.md \
  team-growth/winning-products.md \
  team-growth/fast-selling-products.md \
  team-growth/campaign-ideas.md \
  team-growth/content-ideas.md \
  team-growth/api-research.md \
  team-growth/sdk-research.md \
  team-growth/skill-backlog.md \
  team-growth/downloaded-tools.md \
  team-growth/sandbox-tests.md \
  team-growth/risks.md \
  team-growth/decisions.md

cat >> team-growth/hourly-sync.md <<EOM

---

# Ciclo horário — $NOW

## Missão da hora

Shield e MEL devem evoluir conhecimento em:

- vendas
- marketing digital
- tráfego pago
- tráfego orgânico
- infoprodutos
- dropshipping
- produtos ganhadores
- produtos de venda rápida
- APIs úteis
- SDKs úteis
- skills úteis
- automações comerciais

## Perguntas obrigatórias

1. Qual oportunidade comercial nova encontramos?
2. Qual API ou ferramenta vale estudar?
3. Qual skill pode aumentar produtividade?
4. Qual campanha ou criativo pode gerar venda?
5. Qual produto/nicho parece promissor?
6. Qual risco precisa ser evitado?
7. O que deve ser testado em sandbox?
8. O que precisa de aprovação humana?

## Regra

Registrar descobertas no repositório.
Baixar apenas documentação, SDKs oficiais e repositórios para sandbox.
Não usar tokens reais em testes.
Não ativar campanhas pagas.
Não publicar nada automaticamente.
Não prometer dinheiro rápido sem validação real.

EOM

cat >> team-growth/api-research.md <<EOM

---

## Pesquisa de APIs — $NOW

Pesquisar e documentar APIs úteis:

- Meta Marketing API
- Instagram Graph API
- TikTok Marketing API
- Google Ads API
- YouTube Data API
- WhatsApp Business API
- Shopify API
- WooCommerce REST API
- Stripe API
- Mercado Pago API
- Hotmart API
- Kiwify, se disponível
- Eduzz, se disponível
- Braip, se disponível
- RD Station API
- ActiveCampaign API
- Mailchimp API
- Brevo API
- Notion API
- Airtable API
- Google Sheets API

Para cada API registrar:
- link oficial
- finalidade
- autenticação necessária
- riscos
- custo
- casos de uso para vendas
- possibilidade de skill
EOM

cat >> team-growth/skill-backlog.md <<EOM

---

## Backlog de Skills — $NOW

Propor skills para:

- gerador de copy
- analisador de produto vencedor
- planejador de campanha Meta Ads
- planejador de campanha TikTok Ads
- criador de carrossel Instagram
- roteirista de Reels/TikTok
- analisador de funil
- gerador de página de vendas
- analisador de criativos
- criador de calendário editorial
- integrador com Google Sheets
- integrador com CRM
- monitor de tendências
- pesquisador de concorrentes permitido
EOM

cat >> team-growth/marketing-research.md <<EOM

---

## Radar de marketing — $NOW

Foco deste ciclo:
- mapear oportunidades de retorno rápido sem prometer ganho;
- priorizar ofertas com dor clara, ticket validável e criativos testáveis;
- separar hipótese de fato comprovado;
- registrar fontes e próximos testes em sandbox.
EOM

cat >> team-growth/paid-traffic.md <<EOM

---

## Tráfego pago — $NOW

Hipóteses seguras para estudo:
- campanhas de mensagens no WhatsApp Business com aprovação humana;
- remarketing somente com consentimento e pixel configurado corretamente;
- testes A/B de criativos antes de escalar orçamento;
- checklist de política Meta/TikTok/Google antes de qualquer publicação.
EOM

cat >> team-growth/organic-traffic.md <<EOM

---

## Tráfego orgânico — $NOW

Ideias de canais:
- Reels/TikTok com demonstração de produto;
- carrossel educativo para dor + solução;
- prova social ética;
- conteúdo de comparação e checklist;
- WhatsApp Business com opt-in, sem spam.
EOM

cat >> team-growth/campaign-ideas.md <<EOM

---

## Ideias de campanha — $NOW

Modelos a desenvolver:
- Problema → demonstração → oferta → chamada para WhatsApp.
- Antes/depois permitido e comprovável, sem promessa enganosa.
- Criativo UGC com teste de 3 ganchos nos primeiros 3 segundos.
- Página simples com oferta, prova, FAQ e garantia clara.
EOM

cat >> team-growth/risks.md <<EOM

---

## Riscos — $NOW

Evitar automaticamente:
- gastar dinheiro ou ativar campanha;
- usar tokens reais em sandbox;
- instalar pacote suspeito fora de sandbox;
- scraping proibido;
- spam em WhatsApp/Instagram/Facebook;
- alegação de renda garantida ou produto milagroso;
- violar políticas de Meta Ads, TikTok Ads, Google Ads ou marketplaces.
EOM

cat >> team-growth/decisions.md <<EOM
- $ISO_NOW — Ciclo horário executado. Repositório atualizado para evolução autônoma segura de Shield/OpenCloud e MEL/Hermes em marketing digital.
EOM

if [ -x ./scripts/scan-secrets.sh ]; then
  ./scripts/scan-secrets.sh || exit 1
else
  echo "ERRO: scripts/scan-secrets.sh não encontrado ou não executável." >&2
  exit 1
fi

git add team-growth sandbox scripts/hourly-growth-sync.sh scripts/scan-secrets.sh
if git diff --cached --quiet; then
  echo "Nada novo para commitar em $NOW"
else
  git commit -m "Hourly growth sync - $NOW" || true
fi
git push || true
