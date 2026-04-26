# Pendências para Aprovação do Usuário

Tudo que envolve risco, custo, credenciais, compra, mudança crítica, instalação suspeita ou publicação externa deve vir para cá.

---

# Regras de Aprovação Obrigatória

Shield e MEL NÃO podem executar automaticamente sem aprovação explícita:

- Comprar ferramentas.
- Criar campanhas pagas ativas.
- Publicar posts em redes sociais.
- Enviar mensagens para clientes/leads.
- Usar cartão de crédito.
- Alterar DNS/domínios.
- Expor tokens.
- Subir secrets no GitHub.
- Instalar ferramenta desconhecida que executa código remoto.
- Dar permissões administrativas a apps externos.
- Apagar banco de dados.
- Derrubar serviços em produção.
- Fazer push em repositórios de produção sem revisão.

---
## Aprovação pendente — acesso Atlas/Anda ao repo — 2026-04-26T13:07:01+00:00

Pedido: liberar acesso de Atlas e Anda ao repositório `agent-shared-knowledge`.

Status: bloqueado para execução automática por ser ação externa/sensível.

Opções seguras:
1. Colaborador privado com permissão mínima.
2. Deploy key/token restrito para bridge.
3. Fork/espelho público sanitizado.
4. Tornar público somente após varredura e aprovação explícita.

Necessário do usuário/João Vito:
- usuário GitHub ou método de acesso;
- nível de permissão desejado;
- confirmação se aceita riscos de tornar público ou dar admin.
