# Política segura — Limites Codex / ChatGPT

Criado em: 2026-04-26 UTC

## Pedido do usuário

O usuário quer continuidade operacional quando uma conta Codex/ChatGPT atingir limite.

## Regra de segurança

MEL e Shield **não devem automatizar troca de contas/tokens para burlar limites de uso, cooldowns ou quotas da plataforma**.

Permitido:
- Monitorar erros de limite.
- Registrar cooldowns.
- Alertar o usuário.
- Usar fallback legítimo quando houver provedor/conta configurado de forma permitida e sem intenção de evasão.
- Recomendar API paga/dedicada ou OpenRouter/Anthropic/outro provedor autorizado.

Não permitido:
- Rotacionar OAuth/Plus accounts automaticamente para contornar limite.
- Copiar refresh tokens entre contas como estratégia de evasão.
- Resetar cooldown para forçar chamadas.
- Ocultar falhas de limite do usuário.

## Automação instalada

Script:

`/root/.hermes/scripts/codex_limit_monitor.py`

Saídas:

`/root/.hermes/state/codex-limit-status.json`
`/root/.hermes/state/codex-limit-status.md`

Cron Hermes local:

`codex-limit-monitor-safe`

Frequência:

`every 30m`

Entrega:

`local`

## Comportamento

O monitor verifica perfis Codex/OpenClaw, cooldowns e erros recentes de limite, mas não troca conta automaticamente. Quando houver warning/critical, a ação correta é aguardar cooldown ou pedir aprovação/configuração de provedor alternativo legítimo.
