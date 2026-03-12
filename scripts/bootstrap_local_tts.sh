#!/usr/bin/env bash
set -euo pipefail
TTS_URL="${TTS_URL:-http://127.0.0.1:8765/health}"
CRON_VOICE_URL="${CRON_VOICE_URL:-http://127.0.0.1:8786/health}"
printf 'tts_health_url=%s\n' "$TTS_URL"
curl -fsS "$TTS_URL" || true
echo
printf 'cron_voice_health_url=%s\n' "$CRON_VOICE_URL"
curl -fsS "$CRON_VOICE_URL" || true
echo
if command -v launchctl >/dev/null 2>&1; then
  echo 'launchd_matches:'
  launchctl list | rg 'openclaw|qwen|tts' || true
fi
