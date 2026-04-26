# Onboarding Atlas e Anda — integração com MEL + Shield

Objetivo: colocar Atlas e Anda no mesmo sistema operacional compartilhado de MEL e Shield, usando este repositório como barramento seguro de trabalho.

## O que João Vito precisa enviar

Preencher `team-sync/atlas-anda-intake-template.md` para cada agente:

- Atlas
- Anda

Sem tokens, sem senhas e sem cookies. Se precisar mencionar credencial, escrever apenas `[REDACTED]`.

## Setup mínimo recomendado

1. Dar acesso ao repositório `agent-shared-knowledge` para o ambiente do Atlas/Anda.
2. Clonar o repo no servidor/máquina deles.
3. Configurar cada agente para ler:
   - `team-sync/inbox-atlas.md` ou `team-sync/inbox-anda.md`
   - `team-sync/live/live-feed.md`
   - `workflows/four-agent-shared-operating-system.md`
   - `projects/<slug>/master-plan.md`
4. Configurar cada agente para escrever inicialmente apenas em:
   - Atlas: `team-sync/live/atlas-notes.md` e `team-sync/inbox-atlas.md`
   - Anda: `team-sync/live/anda-notes.md` e `team-sync/inbox-anda.md`
5. Rodar sincronização manual primeiro. Só depois ativar cron/bridge.

## Primeiro teste de integração

MEL ou Shield cria um pedido em `team-sync/inbox-atlas.md`:

```md
## Pedido — <UTC>
De: Shield
Para: Atlas
Projeto: teste-integracao
Prioridade: média
Status: aberto

### Contexto
Teste de comunicação via repositório compartilhado.

### Preciso que você faça
Responder em `team-sync/live/atlas-notes.md` com uma confirmação curta.

### Entregável esperado
Confirmação de leitura e escrita.

### Restrições
Não usar credenciais reais. Não publicar. Não enviar mensagens externas.
```

E um pedido equivalente para Anda.

## Critério de sucesso

- Atlas lê o pedido e responde no arquivo certo.
- Anda lê o pedido e responde no arquivo certo.
- Nenhum agente escreve fora da própria área no primeiro teste.
- Nenhum segredo aparece no Git.
- O histórico fica commitado.

## Próximo passo depois do teste

Criar um projeto real usando `projects/_templates/four-agent-project-template.md` e dividir tarefas:

- Atlas: pesquisa/mercado/concorrentes.
- Anda: conteúdo/suporte/FAQ.
- Shield: estratégia/riscos/vendas.
- MEL: automação/infra/integração.
