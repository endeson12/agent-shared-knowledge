# Playbooks de Comandos

## OpenClaw
```bash
openclaw status
openclaw gateway status
openclaw cron list
openclaw devices list
```

## Hermes / MEL
```bash
hermes status
hermes doctor
hermes config check
hermes gateway status
hermes cron list
hermes -z 'MEL operacional?'
```

## Financeiroms
```bash
systemctl status financeiroms-portal.service --no-pager
systemctl status finance-chat-http.service --no-pager
curl http://127.0.0.1:3000/api/health
curl http://127.0.0.1:8011/health
```

## Áudio Telegram local
```bash
/root/.openclaw/workspace/tools/transcribe-audio.sh arquivo.ogg pt
```
