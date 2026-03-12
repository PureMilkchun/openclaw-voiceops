#!/usr/bin/env bash
set -euo pipefail
MODE="${1:-inspect}"
echo '== gateway health =='
command -v openclaw >/dev/null 2>&1 && openclaw gateway health || true
echo '== local tts health =='
curl -fsS http://127.0.0.1:8765/health || true
echo
echo '== cron voice health =='
curl -fsS http://127.0.0.1:8786/health || true
echo
if [ "$MODE" = "recover" ]; then
  echo '== restart gateway =='
  openclaw gateway restart || true
fi
