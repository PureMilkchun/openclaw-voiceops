#!/usr/bin/env bash
set -euo pipefail
OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
LOG_DATE="${LOG_DATE:-$(date +%F)}"
GATEWAY_LOG="/tmp/openclaw/openclaw-${LOG_DATE}.log"
CRON_VOICE_LOG="$OPENCLAW_HOME/logs/cron-voice-delivery.log"
TTS_LOG="/tmp/local-qwen-tts.err.log"
echo '== gateway health =='
command -v openclaw >/dev/null 2>&1 && openclaw gateway health || true
echo '== tts health =='
curl -fsS http://127.0.0.1:8765/health || true
echo
echo '== cron voice health =='
curl -fsS http://127.0.0.1:8786/health || true
echo
for f in "$GATEWAY_LOG" "$CRON_VOICE_LOG" "$TTS_LOG"; do
  echo "== tail $f =="
  [ -f "$f" ] && tail -n 60 "$f" || echo missing
  echo
done
