# Histórico de Projetos

## OpenClaw / Shield
- OpenClaw atualizado para 2026.4.23.
- Modelo padrão liberado/configurado como openai-codex/gpt-5.5.
- Image generation testado com openai/gpt-image-2, mas cota foi atingida depois.
- Transcrição local de áudio configurada com whisper.cpp e script `tools/transcribe-audio.sh`.

## Hermes / MEL
- Hermes Agent instalado em `/usr/local/lib/hermes-agent`.
- Diretório de dados/configuração: `/root/.hermes`.
- MEL configurada com persona própria em `~/.hermes/MEL.md` e `~/.hermes/SOUL.md`.
- OpenAI Codex OAuth importado para Hermes auth store.
- MEL validada via CLI com `hermes -z`, respondendo como MEL.
- Telegram da MEL configurado com bot próprio e gateway Hermes rodando como serviço user systemd.

## Financeiroms / projeto financeiro
- Portal existente em `/root/.openclaw/workspace/Financeiroms/web`.
- Portal VPS validado em `http://76.13.234.134:3000/login`.
- Serviços criados/validados: `financeiroms-portal.service`, `finance-chat-http.service`.
- Finance chat HTTP criado em `finance_chat_http_server.py`, porta local 8011.
- Autenticação, perfil, usuários/admin e rotas internas do portal foram trabalhadas.
- Projeto pausado a pedido do usuário.
- Ingestão SMB bloqueada por `Host is down` em `/mnt/financeiro_ti`.

## Shield Knowledge Base
- Repositório privado criado: `endeson12/shield-knowledge-base`.
- Usado para conhecimento evolutivo de vendas, agentes, legal e automações.
