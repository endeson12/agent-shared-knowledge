# Mensagem para João Vito — integração Atlas/Anda com MEL/Shield

João, queremos integrar seus agentes **Atlas** e **Anda** com os agentes **MEL** e **Shield** do Endeson para os quatro trabalharem como uma equipe compartilhada em projetos comerciais.

A ideia inicial é usar o repositório `agent-shared-knowledge` como barramento de trabalho: cada agente lê tarefas, escreve respostas nos próprios arquivos, compartilha conhecimento e divide funções. Nada de token, senha, gasto, publicação ou ação externa sem aprovação humana.

## O que precisamos que você envie de cada agente

Preencha um bloco para o **Atlas** e outro para a **Anda**:

```md
# Cadastro de Agente Externo

Nome: Atlas ou Anda
Dono/responsável: João Vito
Plataforma/runtime: Hermes | OpenClaw | Claude Code | Codex | API própria | n8n | outro
Onde roda: VPS | máquina local | cloud | celular | navegador | serviço hospedado | outro
Sistema operacional/shell, se houver:
Comando, endpoint, webhook ou bot para acionar:
Diretório de sessões/logs, se houver:
Pode usar Git? sim/não
Usuário GitHub ou método de acesso:
Permissão desejada no repo: leitura | inbox própria | projetos | PR | push main
Pode rodar automático? sim/não
Frequência segura: manual | 1 min | 5 min | hourly
Pode receber mensagens compartilhadas do projeto? sim/não
Pode escrever no repo? sim/não
Arquivos que deve escrever:
Função principal desejada: pesquisa | marketing | conteúdo | suporte | organização | código | QA | outro
Limites/proibições:
Formato preferido de prompt para acionar esse agente:
Observações:
```

## Regras de segurança da integração

- Não enviar token, senha, cookie, chave privada ou credencial completa.
- Se precisar mencionar credencial, escreva só `[REDACTED]`.
- Começar com permissão mínima: ler o repo e escrever só nos próprios arquivos.
- Nada de publicar loja, anúncio, post, mensagem para cliente ou gastar dinheiro sem aprovação humana.
- Nada de usar contas reais/produção no primeiro teste.

## Arquivos que vamos usar

- Atlas escreve em:
  - `team-sync/live/atlas-notes.md`
  - `team-sync/inbox-atlas.md`
  - `projects/<projeto>/work-atlas.md`

- Anda escreve em:
  - `team-sync/live/anda-notes.md`
  - `team-sync/inbox-anda.md`
  - `projects/<projeto>/work-anda.md`

- MEL escreve em:
  - `team-sync/live/mel-notes.md`
  - `team-sync/inbox-mel.md`
  - `projects/<projeto>/work-mel.md`

- Shield escreve em:
  - `team-sync/live/shield-notes.md`
  - `team-sync/inbox-shield.md`
  - `projects/<projeto>/work-shield.md`

## Primeiro teste

Quando Atlas e Anda tiverem acesso ao repo:

1. Eles leem `team-sync/inbox-atlas.md` e `team-sync/inbox-anda.md`.
2. Atlas responde em `team-sync/live/atlas-notes.md`.
3. Anda responde em `team-sync/live/anda-notes.md`.
4. A resposta pode ser simples:

```md
## Confirmação — <data UTC>
Li o pedido de integração.
Consigo assumir inicialmente: <função>.
Limites atuais: <limites>.
```

## Funções sugeridas

- **MEL**: coordenação técnica, automação, integrações e infraestrutura.
- **Shield**: estratégia comercial, riscos, memória operacional e revisão cruzada.
- **Atlas**: pesquisa de mercado, concorrentes, fornecedores, tendências e validação de nicho.
- **Anda**: conteúdo, suporte, FAQ, scripts de atendimento, documentação e QA de experiência.
