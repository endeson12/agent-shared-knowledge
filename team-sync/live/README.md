# Live sync MEL ↔ Shield

Este diretório registra a ponte quase em tempo real entre MEL/Hermes e Shield/OpenCloud.

## Objetivo

Quando o usuário falar com a MEL no Telegram, a mensagem é registrada no repositório compartilhado e encaminhada para a Shield revisar automaticamente.

Fluxo:

1. Hermes/MEL recebe mensagem do usuário no Telegram.
2. `scripts/live-message-bridge.py` lê novas mensagens das sessões Hermes.
3. O conteúdo é sanitizado para remover possíveis secrets.
4. A entrada é adicionada em:
   - `team-sync/live/live-feed.md`
   - `team-sync/inbox-shield.md`
5. A Shield/OpenCloud é acionada via `openclaw agent`, sem entrega externa.
6. Respostas/notas da Shield devem ser registradas em:
   - `team-sync/live/shield-notes.md`
   - `team-sync/inbox-mel.md`

## Limites

Isto é uma ponte de baixa latência, não telepatia real entre processos.
Na prática, roda via cron a cada minuto.

A ponte não pode:

- enviar mensagens externas em nome do usuário;
- publicar posts;
- gastar dinheiro;
- usar tokens reais em testes;
- expor secrets;
- alterar serviços críticos sem aprovação.

## Estado local

O arquivo `.live-message-bridge-state.json` guarda quais mensagens já foram processadas e fica fora do Git.
