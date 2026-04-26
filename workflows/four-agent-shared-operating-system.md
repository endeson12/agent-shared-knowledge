# Sistema Operacional Compartilhado — MEL + Shield + Atlas + Anda

Criado em: 2026-04-26 12:52 UTC

## Objetivo

Permitir que quatro agentes trabalhem como uma equipe única, com conhecimento compartilhado, divisão de funções, execução paralela, revisão cruzada e memória operacional persistida em Git.

Agentes previstos:

- **MEL** — agente Hermes principal do Endeson/Marcell.
- **Shield** — agente OpenClaw/OpenCloud do Endeson/Marcell.
- **Atlas** — agente da equipe do João Vito, a integrar.
- **Anda** — agente da equipe do João Vito, a integrar.

## Princípio de integração

O repositório `agent-shared-knowledge` deve funcionar como o **barramento de coordenação** da equipe. Nenhum agente precisa ter acesso direto à memória privada dos outros; cada agente publica e consome arquivos padronizados.

Isso evita dependência de uma plataforma específica e permite operar com Hermes, OpenClaw, Codex, Claude Code, outro servidor, outro Telegram ou outro backend.

## Níveis de integração

### Nível 1 — Assíncrono por Git

Mais simples e seguro.

- Cada agente clona o repositório.
- Cada agente lê os arquivos de `team-sync/`, `projects/` e `workflows/`.
- Cada agente escreve somente nos seus arquivos permitidos.
- Commits e pushes sincronizam o estado.

Latência típica: manual, cron ou alguns minutos.

### Nível 2 — Quase em tempo real por cron/bridge

Recomendado para o cenário de “trabalhar ao vivo”.

- Cada lado roda um bridge local.
- O bridge lê mensagens/tarefas novas no ambiente do agente.
- Sanitiza secrets.
- Escreve no repositório.
- Opcionalmente aciona outro agente localmente.

Latência típica: 1 minuto.

### Nível 3 — Orquestrador central

Para projetos maiores.

- Um processo central cria missões.
- Distribui tarefas para agentes por função.
- Recolhe respostas.
- Consolida status diário.
- Bloqueia ações sensíveis até aprovação humana.

Latência típica: sob demanda.

## Papéis iniciais recomendados

| Agente | Papel primário | Papel secundário | Saídas esperadas |
|---|---|---|---|
| MEL | Coordenação, engenharia, automação, integração | Revisão técnica e organização | planos, código, infra, checklists, status consolidado |
| Shield | Memória operacional, revisão, estratégia comercial | Pesquisa e marketing | riscos, histórico, campanhas, oportunidades, revisão cruzada |
| Atlas | Pesquisa, inteligência de mercado, benchmarking | Estratégia de produto | pesquisas, comparativos, fornecedores, tendências, validação de nicho |
| Anda | Conteúdo, suporte, operação, documentação | QA e atendimento | copies, FAQ, scripts de suporte, documentação, testes de fluxo |

Esses papéis são padrão inicial. Podem mudar por projeto.

## Estrutura de arquivos para quatro agentes

```text
team-sync/
  live/
    live-feed.md
    mel-notes.md
    shield-notes.md
    atlas-notes.md
    anda-notes.md
  inbox-mel.md
  inbox-shield.md
  inbox-atlas.md
  inbox-anda.md
  decisions.md
  blockers.md
  daily-briefing.md

projects/<slug>/
  intake.md
  master-plan.md
  backlog.md
  status.md
  approvals.md
  handoff.md
  work-mel.md
  work-shield.md
  work-atlas.md
  work-anda.md
  qa.md
  launch-checklist.md
```

## Protocolo de mensagem entre agentes

Todo pedido entre agentes deve seguir este formato:

```md
## Pedido — <UTC>
De: <MEL|Shield|Atlas|Anda>
Para: <MEL|Shield|Atlas|Anda|Todos>
Projeto: <slug ou geral>
Prioridade: baixa | média | alta | urgente
Status: aberto | em andamento | bloqueado | concluído

### Contexto
- ...

### Preciso que você faça
- ...

### Entregável esperado
- ...

### Arquivos relevantes
- ...

### Restrições
- Não usar credenciais reais.
- Não publicar, comprar, enviar ou alterar produção sem aprovação.
```

## Fluxo para criar produto/loja

1. **Intake humano**
   - objetivo financeiro;
   - nicho;
   - orçamento;
   - prazo;
   - plataforma: Nuvemshop, Cartpanda, Shopify, WooCommerce etc.;
   - restrições legais/operacionais.

2. **Plano mestre**
   - MEL cria `projects/<slug>/master-plan.md`.
   - Divide trilhas e responsáveis.

3. **Pesquisa paralela**
   - Atlas pesquisa mercado, concorrentes, fornecedores, ticket, tendências.
   - Shield valida histórico, riscos, canais de venda e oportunidades.

4. **Oferta e conteúdo**
   - Anda cria copies, FAQ, scripts de atendimento, páginas e conteúdo.
   - MEL estrutura páginas, integrações, automações e catálogo.

5. **Revisão cruzada**
   - Shield revisa viabilidade comercial.
   - MEL revisa técnica/segurança.
   - Atlas revisa dados e mercado.
   - Anda revisa clareza, suporte e experiência do cliente.

6. **Aprovação humana**
   - orçamento de tráfego;
   - publicação de loja;
   - uso de credenciais;
   - envio de mensagens;
   - compra de domínio/apps/assinaturas.

7. **Execução assistida**
   - agentes executam tarefas permitidas;
   - ações sensíveis ficam em `projects/<slug>/approvals.md`.

8. **Relatório de retorno**
   - status diário;
   - próximos testes;
   - métricas;
   - gargalos;
   - decisão de escalar, pausar ou pivotar.

## Regras de segurança

Permitido automaticamente:

- pesquisar informações públicas;
- criar documentos, planos, scripts seguros e checklists;
- propor campanhas e copies;
- organizar tarefas;
- revisar código e arquivos;
- fazer commit de documentação sem secrets.

Exige aprovação humana:

- gastar dinheiro;
- publicar anúncios ou posts;
- enviar mensagens para clientes/leads;
- usar tokens, senhas, chaves Pix, gateways ou contas reais;
- alterar DNS, checkout, produção, banco de dados ou infraestrutura crítica;
- apagar dados.

Proibido no repositório:

- tokens completos;
- senhas;
- cookies;
- chaves privadas;
- dumps de banco com dados sensíveis;
- dados pessoais desnecessários de clientes.

## Informações necessárias do Atlas e da Anda

Para integrar de verdade, precisamos que João Vito forneça, para cada agente:

1. **Nome exato do agente**.
2. **Plataforma/runtime**: Hermes, OpenClaw, Claude Code, Codex, API própria, n8n, outro.
3. **Onde roda**: VPS, máquina local, cloud, celular, navegador, serviço hospedado.
4. **Sistema operacional e shell** quando houver servidor.
5. **Forma de acionar o agente**:
   - comando CLI;
   - endpoint HTTP;
   - webhook;
   - bot Telegram/Discord;
   - outro.
6. **Diretório de sessões/logs**, se existir e puder ser lido por bridge local.
7. **Capacidade de clonar/puxar/enviar para GitHub**.
8. **Usuário GitHub ou chave deploy** a usar no repositório.
9. **Permissões desejadas**:
   - somente leitura;
   - escrever apenas inbox própria;
   - escrever em projetos;
   - executar scripts;
   - abrir PR;
   - push direto na main.
10. **Limites de segurança** do ambiente dele.
11. **Formato preferido de prompt** para pedir tarefa ao agente.
12. **Se o agente pode ser acionado automaticamente** por cron/webhook ou somente manualmente.
13. **Se pode receber contexto de mensagens do Endeson/Marcell e João Vito** dentro desse repositório.
14. **Qual idioma e estilo de resposta**.
15. **Quais funções João quer que Atlas e Anda assumam inicialmente**.

## Modelo mínimo que João Vito pode preencher

```md
# Cadastro de Agente Externo

Nome: Atlas ou Anda
Dono/responsável: João Vito
Plataforma/runtime:
Onde roda:
Sistema operacional:
Comando ou endpoint para acionar:
Diretório de sessões/logs, se houver:
Pode usar Git? sim/não
Usuário GitHub ou método de acesso:
Permissão desejada no repo: leitura | inbox própria | projetos | PR | push main
Pode rodar automático? sim/não
Frequência segura: manual | 1 min | 5 min | hourly
Pode receber mensagens compartilhadas do projeto? sim/não
Pode escrever no repo? sim/não
Arquivos que deve escrever:
Função principal desejada:
Limites/proibições:
Observações:
```

## Recomendação prática

Começar com **Nível 1 + Nível 2 parcial**:

1. Adicionar Atlas e Anda como colaboradores ou deploy keys no GitHub.
2. Criar `team-sync/inbox-atlas.md`, `team-sync/inbox-anda.md`, `team-sync/live/atlas-notes.md` e `team-sync/live/anda-notes.md`.
3. Cada agente escreve somente na própria inbox/notes no início.
4. MEL consolida `daily-briefing.md`.
5. Depois que provar estabilidade, ativar bridges automáticos de 1 minuto.

## Critério de pronto

A integração está funcionando quando:

- os quatro agentes conseguem ler o mesmo plano;
- cada agente escreve no próprio arquivo;
- MEL consegue consolidar o status;
- tarefas são divididas sem conflito;
- nenhuma credencial aparece no Git;
- ações sensíveis ficam pendentes de aprovação humana;
- um projeto real consegue avançar em paralelo com entregáveis verificáveis.
