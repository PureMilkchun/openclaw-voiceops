#!/usr/bin/env bash
set -euo pipefail
OUT="${1:-/tmp/OPENCLAW_RUNBOOK.md}"
cat > "$OUT" <<'MD'
# OpenClaw Runbook

1. Check gateway health:
   `openclaw gateway health`
2. Restart the gateway if Telegram is not ok:
   `openclaw gateway restart`
3. Check local TTS:
   `curl http://127.0.0.1:8765/health`
4. Check cron voice sidecar:
   `curl http://127.0.0.1:8786/health`
5. If still broken, inspect:
   - `/tmp/openclaw/openclaw-YYYY-MM-DD.log`
   - `~/.openclaw/logs/cron-voice-delivery.log`
   - `/tmp/local-qwen-tts.err.log`
MD
echo "$OUT"
