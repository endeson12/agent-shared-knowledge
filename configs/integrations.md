# Integrações

## Telegram
- Shield usa bot próprio OpenClaw.
- MEL usa bot próprio Hermes.
- Não compartilhar token entre gateways ativos.

## WhatsApp
- Suportado pelo OpenClaw/Hermes, mas pareamento foi pausado.
- Objetivo futuro: assistente pessoal de triagem, resumo e rascunhos.

## Supabase / Financeiroms
- Usado para dados financeiros e portal.
- Secrets devem ficar em `.env.local`/secret store, nunca neste repo.

## SMB / Scanner financeiro
- Origem esperada: `//192.168.2.18/ti`.
- Mount esperado: `/mnt/financeiro_ti`.
- Intake esperado: `/mnt/financeiro_ti/entrada_financeiro`.
- Estado conhecido: inacessível/Host is down.
