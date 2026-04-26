#!/usr/bin/env bash
set -euo pipefail

echo "Escaneando possíveis secrets..."

PATTERNS=(
 "sk-[A-Za-z0-9_-]{20,}"
 "ghp_[a-zA-Z0-9]"
 "github_pat_"
 "xoxb-"
 "BEGIN PRIVATE KEY"
 "BEGIN RSA PRIVATE KEY"
 "api_key[[:space:]]*=[[:space:]]*[^[:space:]#]"
 "API_KEY[[:space:]]*=[[:space:]]*[^[:space:]#]"
 "token[[:space:]]*=[[:space:]]*[^[:space:]#]"
 "TOKEN[[:space:]]*=[[:space:]]*[^[:space:]#]"
 "password[[:space:]]*=[[:space:]]*[^[:space:]#]"
 "PASSWORD[[:space:]]*=[[:space:]]*[^[:space:]#]"
 "[0-9]{8,}:[A-Za-z0-9_-]{20,}"
)

FOUND=0
TMP="/tmp/agent-shared-secret-scan-result.txt"
for pattern in "${PATTERNS[@]}"; do
  if grep -REIn --exclude-dir=.git --exclude='scan-secrets.sh' --exclude='*-runtime.log' "$pattern" . > "$TMP" 2>/dev/null; then
    echo "Possível secret encontrado com padrão: $pattern"
    cat "$TMP"
    FOUND=1
  fi
done

rm -f "$TMP"
if [ "$FOUND" -eq 1 ]; then
  echo "ERRO: possíveis secrets encontrados. Remova antes de commitar."
  exit 1
fi

echo "OK: nenhum secret óbvio encontrado."
