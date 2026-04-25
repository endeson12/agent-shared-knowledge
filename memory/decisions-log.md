# Registro de Decisões

## 2026-04-25 — Usar MEL como agente Hermes
Contexto: usuário solicitou instalação do Hermes Agent com nome MEL.
Decisão: instalar Hermes oficial, migrar memórias/configs permitidas, importar OpenAI Codex e configurar MEL como persona.
Motivo: criar nova agente evolutiva com memória e skills.
Impacto: MEL responde via CLI e Telegram próprio; OpenClaw/Shield ainda permanece ativo.

## 2026-04-25 — Não iniciar Hermes com o mesmo Telegram do OpenClaw
Contexto: OpenClaw já usava Telegram ativo.
Decisão: usar bot Telegram próprio da MEL.
Motivo: evitar conflito de polling/sessão entre gateways.
Impacto: MEL tem canal separado; Shield continua ativa.

## 2026-04-25 — CPF apenas com consentimento próprio
Contexto: usuário discutiu produto de consulta por CPF.
Decisão: aceitar apenas desenho seguro de autoatendimento com consentimento do próprio titular e fontes legais/contratadas.
Motivo: reduzir risco de LGPD/doxxing.
Impacto: documentar variáveis/fontes e evitar coleta invasiva de terceiros.
