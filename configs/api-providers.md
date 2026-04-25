# Provedores de API

## OpenAI Codex
- Uso: modelo principal dos agentes.
- Modelo atual: openai-codex/gpt-5.5.
- Credencial: OAuth local no auth store; não versionar.

## Telegram
- Variáveis: TELEGRAM_BOT_TOKEN, TELEGRAM_ALLOWED_USERS.
- Uso: comunicação dos agentes.
- Observação: Shield e MEL devem usar bots/tokens separados para evitar conflito.

## GitHub
- Variável: GITHUB_TOKEN.
- Uso: criar repositórios, push/pull, gerenciamento de knowledge base.
- Observação: token já apareceu em chat e deve ser rotacionado futuramente.

## Supabase
- Variáveis: SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, SUPABASE_SERVICE_ROLE_KEY.
- Uso: projeto financeiro/Financeiroms.

## n8n
- Variáveis: N8N_BASE_URL, N8N_API_KEY.
- Uso: automações.
