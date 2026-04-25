#!/usr/bin/env bash
set -euo pipefail

echo "Sincronizando conhecimento da Shield..."
{
  echo
  echo "## $(date -Is)"
  echo "Sync executado pela Shield."
} >> logs/sync-log.md

./scripts/scan-secrets.sh
git status
