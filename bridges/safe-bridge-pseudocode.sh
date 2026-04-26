#!/usr/bin/env bash
# Pseudocódigo seguro para Atlas/Anda/MEL/Shield adaptarem no próprio ambiente.
# Não colocar tokens neste arquivo.
set -euo pipefail

REPO="/path/to/agent-shared-knowledge"
AGENT_NAME="atlas" # atlas | anda | mel | shield
ALLOWED_FILES=(
  "team-sync/live/${AGENT_NAME}-notes.md"
  "team-sync/inbox-${AGENT_NAME}.md"
)

cd "$REPO"
git pull --rebase

# 1. Ler inbox própria.
# 2. Acionar agente local manual/CLI/API conforme ambiente.
# 3. Escrever saída apenas nos arquivos permitidos.

if grep -RInE '(sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9_]{20,}|AIza[0-9A-Za-z_-]{20,}|-----BEGIN .*PRIVATE KEY|xox[baprs]-|Bearer [A-Za-z0-9._-]{20,})' "${ALLOWED_FILES[@]}" 2>/dev/null; then
  echo "Secret potencial detectado. Substitua por [REDACTED] antes de commit." >&2
  exit 1
fi

git add "${ALLOWED_FILES[@]}"
git commit -m "${AGENT_NAME}: sync update - $(date -u +%Y-%m-%dT%H:%M:%SZ)" || true
git push
