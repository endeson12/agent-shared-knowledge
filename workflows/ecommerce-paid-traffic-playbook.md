# Playbook de Projeto — Loja Virtual + Tráfego Pago

Criado em: 2026-04-25 19:27:17 UTC

## Objetivo

Executar projetos de e-commerce ou loja virtual com MEL e Shield trabalhando como equipe: uma agente focada em implantação/estrutura e outra focada em oferta/marketing/tráfego.

## Estrutura de pastas por projeto

Criar:

```text
projects/<slug-do-projeto>/
├── intake.md
├── master-plan.md
├── backlog.md
├── work-mel.md
├── work-shield.md
├── handoff.md
├── approvals.md
├── assets.md
├── products.md
├── campaigns.md
└── daily-status.md
```

## Intake mínimo

```md
# Intake — <Projeto>

Objetivo:
Nicho:
Público-alvo:
Produtos iniciais:
Plataforma desejada:
Domínio:
Gateway de pagamento:
Orçamento de tráfego:
Prazo:
Credenciais disponíveis por variável de ambiente:
Aprovações obrigatórias:
```

## Divisão de responsabilidades

### MEL — Loja, dados e automações

Checklist:
- [ ] Validar plataforma escolhida.
- [ ] Confirmar domínio/DNS sem alterar sem aprovação.
- [ ] Criar estrutura de catálogo.
- [ ] Organizar produtos em `products.md`.
- [ ] Preparar descrições otimizadas.
- [ ] Configurar páginas essenciais: início, produto, política, contato.
- [ ] Preparar integrações: pagamento, frete, WhatsApp/CRM, pixel.
- [ ] Criar checklist de QA de compra.
- [ ] Documentar variáveis de ambiente necessárias, sem valores reais.

### Shield — Oferta, tráfego e criativos

Checklist:
- [ ] Pesquisar mercado e concorrentes.
- [ ] Definir ângulos de venda.
- [ ] Criar promessa central e objeções.
- [ ] Criar copies para página de produto.
- [ ] Criar legendas para Instagram/TikTok/Facebook.
- [ ] Criar roteiros curtos de vídeo.
- [ ] Montar campanhas em `campaigns.md`.
- [ ] Sugerir públicos, interesses e testes A/B.
- [ ] Revisar clareza comercial da loja.

### Usuário — Decisão e aprovação

Checklist:
- [ ] Aprovar produtos.
- [ ] Aprovar preços.
- [ ] Aprovar orçamento de tráfego.
- [ ] Aprovar publicação de anúncios.
- [ ] Aprovar domínio, checkout e dados legais.
- [ ] Fornecer credenciais por canal seguro quando necessário.

## Backlog padrão

```md
# Backlog — <Projeto>

## Sprint 1 — Fundação
- [ ] Criar intake.
- [ ] Definir nicho/produtos.
- [ ] Validar plataforma.
- [ ] Criar plano mestre.

## Sprint 2 — Loja
- [ ] Criar estrutura de páginas.
- [ ] Adicionar produtos.
- [ ] Configurar checkout.
- [ ] Configurar frete/pagamento.
- [ ] QA de compra.

## Sprint 3 — Marketing
- [ ] Criar proposta/oferta.
- [ ] Criar copies.
- [ ] Criar criativos/roteiros.
- [ ] Criar campanhas.
- [ ] Preparar aprovação do usuário.

## Sprint 4 — Lançamento
- [ ] Revisão cruzada MEL/Shield.
- [ ] Aprovação final do usuário.
- [ ] Publicar loja.
- [ ] Ativar campanhas.
- [ ] Monitorar métricas iniciais.
```

## Template de produtos

```md
# Produtos

## Produto 1 — <Nome>

Status: pesquisar | aprovado | cadastrado | publicado
Preço:
Custo:
Margem estimada:
Fornecedor:
Benefício principal:
Dor que resolve:
Objeções:
Descrição curta:
Descrição longa:
Imagens necessárias:
Públicos prováveis:
Ângulos de anúncio:
```

## Template de campanhas

```md
# Campanhas

## Campanha 1 — <Nome>

Status: rascunho | aguardando aprovação | ativa | pausada | encerrada
Objetivo: conversão | tráfego | leads | mensagens
Produto:
Público:
Promessa:
Criativo:
Copy principal:
Legenda:
CTA:
Orçamento sugerido:
Hipótese testada:
Métrica de sucesso:
Aprovação do usuário: pendente | aprovada | recusada
```

## Ritual de execução

1. MEL cria/atualiza `master-plan.md` e `work-mel.md`.
2. MEL envia handoff para Shield em `team-sync/inbox-shield.md`.
3. Shield responde em `team-sync/inbox-mel.md` ou `work-shield.md`.
4. MEL consolida status em `daily-status.md`.
5. Qualquer ação externa vai para `approvals.md` e aguarda usuário.

## Bloqueios comuns

- Falta de produto definido.
- Falta de credencial de loja/gateway.
- Falta de orçamento aprovado.
- Falta de imagens.
- Falta de política comercial/frete/devolução.

## Regras de segurança

- Nunca salvar token, senha, chave Pix, cartão ou credencial real neste repositório.
- Nunca ativar campanha paga sem aprovação explícita.
- Nunca publicar anúncio/post em nome do usuário sem aprovação.
- Nunca alterar DNS/checkout sem checklist e aprovação.
