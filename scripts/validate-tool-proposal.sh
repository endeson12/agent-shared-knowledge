#!/usr/bin/env bash
set -euo pipefail

cat <<'QUESTIONS'
Antes de instalar qualquer nova skill/ferramenta, responder:
1. Qual problema isso resolve?
2. Qual fonte oficial?
3. É open-source?
4. Tem manutenção recente?
5. Exige token?
6. Exige pagamento?
7. Pode acessar dados sensíveis?
8. Pode executar comandos?
9. Tem risco de segurança?
10. Qual rollback?

Se houver risco alto, registrar em team-sync/pending-user-approval.md
QUESTIONS
