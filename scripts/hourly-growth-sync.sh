#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/agent-shared-knowledge"
cd "$REPO"

git pull --rebase || true

NOW="$(date '+%Y-%m-%d %H:%M:%S')"
ISO_NOW="$(date -Is)"

cat >> team-growth/hourly-sync.md <<EOM

---

# Ciclo horário — $NOW

## Missão da hora

Shield/OpenClaw e Mel/Hermes devem evoluir conhecimento em:

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

Registrar descobertas no repositório. Baixar apenas documentação, SDKs oficiais e repositórios públicos para sandbox.
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

cat >> team-growth/risks.md <<EOM

---

## Regras de segurança/autonomia — $NOW

Permitido automaticamente:
- pesquisar ferramentas, APIs, SDKs, skills e documentação oficial;
- baixar repositórios públicos apenas para sandbox;
- criar skills experimentais locais;
- atualizar markdowns e propostas;
- criar scripts de teste sem tokens reais.

Proibido automaticamente:
- gastar dinheiro;
- ativar campanha paga;
- publicar posts reais;
- enviar mensagens para leads/clientes;
- expor tokens;
- instalar pacotes suspeitos fora de sandbox;
- rodar código remoto desconhecido em produção;
- alterar DNS, bancos ou serviços críticos;
- spam, scraping proibido ou bypass de regras;
- prometer dinheiro rápido sem validação.
EOM

cat >> team-growth/decisions.md <<EOM
- $NOW — Ciclo horário executado. Repositório atualizado para evolução autônoma segura de Shield/OpenClaw e Mel/Hermes.
EOM

cat >> team-sync/cron-log.md <<EOM
- $NOW — team-growth hourly sync executado.
EOM

./scripts/scan-secrets.sh || exit 1

git add .
git commit -m "Hourly growth sync - $NOW" || true
git push || true
