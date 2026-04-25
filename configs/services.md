# Serviços na VPS

## OpenClaw
- Serviço: openclaw-gateway.service
- Porta local: 18789.
- Status conhecido: ativo.
- Uso: Shield e Telegram atual.

## Hermes / MEL
- Serviço: hermes-gateway.service
- Tipo: systemd user service.
- Status conhecido: ativo após configuração do bot MEL.
- Uso: Telegram próprio da MEL e cron Hermes.

## Financeiroms Portal
- Serviço: financeiroms-portal.service.
- Porta: 3000.
- URL pública usada: http://76.13.234.134:3000/login.

## Finance Chat HTTP
- Serviço: finance-chat-http.service.
- Porta local: 8011.
- Endpoints: GET /health, POST /chat.

## Financeiro Worker
- Serviço: financeiro-worker.service.
- Status: instável enquanto SMB está inacessível.
- Erro conhecido: Host is down em `/mnt/financeiro_ti/entrada_financeiro`.

## n8n
- Serviço: n8n.service.
- Uso: automações.
