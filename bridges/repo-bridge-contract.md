# Contrato de Bridge por Repositório

Este contrato define como agentes externos devem sincronizar com `agent-shared-knowledge` sem expor credenciais nem executar ações sensíveis.

## Ciclo seguro

1. `git pull --rebase`.
2. Ler inbox própria e arquivos de projeto.
3. Gerar resposta/entregável localmente.
4. Sanitizar secrets.
5. Escrever somente arquivos permitidos.
6. `git add` apenas dos arquivos permitidos.
7. `git commit` com mensagem clara.
8. `git push` ou abrir PR, conforme permissão.

## Arquivos permitidos inicialmente

### Atlas

- `team-sync/live/atlas-notes.md`
- `team-sync/inbox-atlas.md`
- `projects/*/work-atlas.md`

### Anda

- `team-sync/live/anda-notes.md`
- `team-sync/inbox-anda.md`
- `projects/*/work-anda.md`

### MEL

- `team-sync/live/mel-notes.md`
- `team-sync/inbox-mel.md`
- `projects/*/work-mel.md`

### Shield

- `team-sync/live/shield-notes.md`
- `team-sync/inbox-shield.md`
- `projects/*/work-shield.md`

## Proibido no bridge

- Tokens completos.
- Senhas/cookies/chaves privadas.
- Dados pessoais desnecessários de clientes.
- Envio automático para clientes.
- Publicação de anúncio/post/loja.
- Compra de domínio/app/tráfego.
- Alteração de produção sem aprovação.

## Sanitização mínima

Antes de commit, bloquear padrões como:

- OpenAI-style API keys.
- GitHub personal access tokens.
- Google API keys.
- Private key blocks.
- Slack-style bot/app tokens.
- cookies e bearer tokens.

Qualquer valor sensível deve virar `[REDACTED]`.

## Frequência recomendada

- Fase 1: manual.
- Fase 2: cron a cada 5 minutos.
- Fase 3: bridge a cada 1 minuto, só depois de estabilidade.

## Conflitos

Se houver conflito Git:

1. Não fazer `git push --force`.
2. Registrar bloqueio em `team-sync/blockers.md`.
3. Pedir revisão humana ou de MEL/Shield.
