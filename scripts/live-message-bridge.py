#!/usr/bin/env python3
"""Near-real-time MEL <-> Shield bridge through the shared repository.

What it does safely:
- Reads new Telegram user messages from Hermes session JSON files.
- Redacts obvious secrets before writing anything to the repository.
- Appends a live relay entry to team-sync/live/live-feed.md.
- Appends the same entry to team-sync/inbox-shield.md so Shield can see it.
- Optionally triggers one OpenClaw/Shield agent turn without delivering external messages.
- Commits/pushes only when new user messages are found.

It does NOT:
- publish posts;
- send messages to leads/customers;
- spend money;
- expose raw tokens;
- alter production services.
"""
from __future__ import annotations

import hashlib
import json
import os
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Iterable, List, Tuple

REPO = Path(os.environ.get("AGENT_SHARED_REPO", str(Path.home() / "agent-shared-knowledge")))
HERMES_SESSIONS = Path(os.environ.get("HERMES_SESSIONS_DIR", str(Path.home() / ".hermes" / "sessions")))
LIVE_DIR = REPO / "team-sync" / "live"
STATE_PATH = REPO / ".live-message-bridge-state.json"
LOCK_PATH = Path("/tmp/agent-shared-live-message-bridge.lock")
MAX_MESSAGE_CHARS = int(os.environ.get("LIVE_BRIDGE_MAX_MESSAGE_CHARS", "2500"))
OPENCLAW_TIMEOUT = int(os.environ.get("LIVE_BRIDGE_OPENCLAW_TIMEOUT", "240"))
TRIGGER_SHIELD = os.environ.get("LIVE_BRIDGE_TRIGGER_SHIELD", "1") == "1"

# Keep token regexes split so the repository secret scanner does not flag
# the scanner patterns themselves as real credentials.
SECRET_PATTERNS = [
    (re.compile("ghp" + r"_[A-Za-z0-9_]{20,}"), "[REDACTED_GITHUB_TOKEN]"),
    (re.compile("github" + r"_pat_[A-Za-z0-9_:-]{20,}"), "[REDACTED_GITHUB_TOKEN]"),
    (re.compile("sk" + r"-[A-Za-z0-9_-]{20,}"), "[REDACTED_API_KEY]"),
    (re.compile("xox" + r"[baprs]-[A-Za-z0-9-]{20,}"), "[REDACTED_SLACK_TOKEN]"),
    (re.compile(r"\b[0-9]{8,}:[A-Za-z0-9_-]{20,}\b"), "[REDACTED_BOT_TOKEN]"),
    (re.compile(r"(?i)(api[_-]?key|token|password|senha|secret)\s*[:=]\s*\S+"), r"\1=[REDACTED]"),
]

SKIP_USER_PREFIXES = (
    "[CONTEXT COMPACTION",
    "Review the conversation above",
)


def now_iso() -> str:
    return datetime.now(timezone.utc).astimezone().isoformat(timespec="seconds")


def run(cmd: List[str], cwd: Path = REPO, timeout: int = 60, check: bool = False) -> subprocess.CompletedProcess[str]:
    return subprocess.run(cmd, cwd=str(cwd), text=True, capture_output=True, timeout=timeout, check=check)


def redact(text: str) -> str:
    out = text
    for pattern, replacement in SECRET_PATTERNS:
        out = pattern.sub(replacement, out)
    if len(out) > MAX_MESSAGE_CHARS:
        out = out[:MAX_MESSAGE_CHARS] + "\n...[truncado pelo live bridge]"
    return out


def load_json(path: Path, default: Any) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return default


def save_json(path: Path, data: Any) -> None:
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def message_key(session_id: str, index: int, content: str) -> str:
    digest = hashlib.sha256(content.encode("utf-8", errors="ignore")).hexdigest()[:16]
    return f"{session_id}:{index}:{digest}"


def iter_user_messages() -> Iterable[Tuple[str, int, str, str]]:
    for path in sorted(HERMES_SESSIONS.glob("session_*.json"), key=lambda p: p.stat().st_mtime):
        data = load_json(path, {})
        if data.get("platform") not in ("telegram", None):
            continue
        session_id = data.get("session_id") or path.stem.replace("session_", "")
        messages = data.get("messages") or []
        for idx, msg in enumerate(messages):
            if msg.get("role") != "user":
                continue
            content = str(msg.get("content") or "").strip()
            if not content:
                continue
            if content.startswith(SKIP_USER_PREFIXES):
                continue
            yield session_id, idx, content, path.name


def format_entry(items: List[Tuple[str, int, str, str]]) -> str:
    timestamp = now_iso()
    blocks = [
        "\n---\n",
        f"## Entrada ao vivo do usuário — {timestamp}\n",
        "**Origem:** Hermes/MEL Telegram → repositório compartilhado → Shield/OpenClaw\n",
        "**Regra:** tratar como contexto operacional compartilhado; não executar ação sensível sem aprovação do usuário.\n",
    ]
    for session_id, idx, content, filename in items:
        key = message_key(session_id, idx, content)
        safe = redact(content)
        blocks.append(f"\n### Mensagem `{key}`\n")
        blocks.append(f"- Sessão Hermes: `{session_id}`\n")
        blocks.append(f"- Arquivo: `{filename}`\n")
        blocks.append("\n```text\n")
        blocks.append(safe)
        blocks.append("\n```\n")
    return "".join(blocks)


def append(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as f:
        f.write(text)


def trigger_shield(entry: str) -> str:
    if not TRIGGER_SHIELD:
        return "Trigger Shield desativado por LIVE_BRIDGE_TRIGGER_SHIELD=0."
    prompt = f"""
Você é a Shield/OpenCloud trabalhando em equipe ao vivo com MEL/Hermes.

Leia a entrada abaixo, considere que ela veio do usuário e atualize o repositório compartilhado em `/root/agent-shared-knowledge` se houver algo útil a registrar.

Obrigatório:
- Não envie mensagem externa para o usuário ou terceiros.
- Não publique, não gaste dinheiro, não use tokens reais.
- Se responder para MEL, escreva em `team-sync/inbox-mel.md` ou `team-sync/live/shield-notes.md`.
- Se a mensagem pedir integração ao vivo, registre no live sync como decisão/necessidade.
- Não exponha secrets; qualquer token deve virar `[REDACTED]`.

Entrada ao vivo:
{entry}
""".strip()
    try:
        proc = run([
            "openclaw", "agent",
            "--agent", "main",
            "--message", prompt,
            "--timeout", str(OPENCLAW_TIMEOUT),
            "--thinking", "medium",
        ], cwd=REPO, timeout=OPENCLAW_TIMEOUT + 30, check=False)
        output = (proc.stdout or "") + ("\n" + proc.stderr if proc.stderr else "")
        return redact(output.strip() or f"OpenClaw finalizou sem saída textual. exit_code={proc.returncode}")
    except subprocess.TimeoutExpired:
        return f"OpenClaw/Shield excedeu timeout de {OPENCLAW_TIMEOUT}s; entrada já ficou registrada para o próximo ciclo."
    except Exception as exc:
        return f"Falha ao acionar OpenClaw/Shield: {type(exc).__name__}: {exc}"


def main() -> int:
    if LOCK_PATH.exists():
        try:
            old_pid = int(LOCK_PATH.read_text().strip())
            os.kill(old_pid, 0)
            print("live bridge já está rodando; saindo")
            return 0
        except Exception:
            LOCK_PATH.unlink(missing_ok=True)
    LOCK_PATH.write_text(str(os.getpid()))
    try:
        REPO.mkdir(parents=True, exist_ok=True)
        LIVE_DIR.mkdir(parents=True, exist_ok=True)
        state: Dict[str, Any] = load_json(STATE_PATH, {"processed": []})
        processed = set(state.get("processed") or [])
        new_items = []
        for session_id, idx, content, filename in iter_user_messages():
            key = message_key(session_id, idx, content)
            if key in processed:
                continue
            new_items.append((session_id, idx, content, filename))

        if not new_items:
            print("nenhuma nova mensagem do usuário para sincronizar")
            return 0

        # Git sync best-effort before writing.
        run(["git", "pull", "--rebase"], timeout=90, check=False)

        entry = format_entry(new_items)
        append(LIVE_DIR / "live-feed.md", entry)
        append(REPO / "team-sync" / "inbox-shield.md", "\n\n---\n\n## Relay ao vivo MEL → Shield\n" + entry)
        append(LIVE_DIR / "mel-notes.md", f"\n- {now_iso()} — MEL encaminhou {len(new_items)} nova(s) mensagem(ns) do usuário para Shield via live bridge.\n")

        shield_output = trigger_shield(entry)
        append(LIVE_DIR / "shield-last-output.md", f"\n---\n\n## Resultado do acionamento Shield — {now_iso()}\n\n```text\n{shield_output}\n```\n")

        for session_id, idx, content, _ in new_items:
            processed.add(message_key(session_id, idx, content))
        state["processed"] = sorted(processed)[-2000:]
        state["last_run"] = now_iso()
        save_json(STATE_PATH, state)

        scan = run(["./scripts/scan-secrets.sh"], timeout=60, check=False)
        if scan.returncode != 0:
            print(scan.stdout + scan.stderr)
            return scan.returncode

        run(["git", "add", "team-sync/live", "team-sync/inbox-shield.md", "scripts/live-message-bridge.py", ".gitignore"], timeout=60, check=False)
        commit_msg = f"Live bridge sync - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
        run(["git", "commit", "-m", commit_msg], timeout=90, check=False)
        push = run(["git", "push", "origin", "main"], timeout=120, check=False)
        print(f"sincronizadas {len(new_items)} nova(s) mensagem(ns)")
        if push.stdout or push.stderr:
            print((push.stdout + push.stderr)[-2000:])
        return 0
    finally:
        LOCK_PATH.unlink(missing_ok=True)


if __name__ == "__main__":
    raise SystemExit(main())
