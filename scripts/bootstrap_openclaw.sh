#!/usr/bin/env bash
set -euo pipefail
OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
CONFIG="$OPENCLAW_HOME/openclaw.json"
printf 'openclaw_home=%s\n' "$OPENCLAW_HOME"
printf 'config_exists=%s\n' "$([ -f "$CONFIG" ] && echo yes || echo no)"
if command -v openclaw >/dev/null 2>&1; then
  echo 'gateway_health:'
  openclaw gateway health || true
else
  echo 'openclaw_cli=missing'
fi
for p in "$OPENCLAW_HOME/secrets/telegram.bot.token" "$OPENCLAW_HOME/cron/jobs.json"; do
  printf 'path_%s=%s\n' "$(basename "$p" | tr '.-' '__')" "$([ -e "$p" ] && echo present || echo missing)"
done
