# Deployment Model

## Target Stack
- macOS on Apple Silicon Mac mini
- OpenClaw local gateway as orchestrator
- Telegram as primary channel
- Local Qwen3-TTS service exposed as an OpenAI-compatible speech endpoint
- Optional cron voice sidecar for intent-based scheduled voice delivery

## Canonical Paths
Default paths used by this workflow:
- `~/.openclaw/openclaw.json`
- `~/.openclaw/cron/jobs.json`
- `~/.openclaw/secrets/telegram.bot.token`
- `~/Library/LaunchAgents/`
- local TTS health: `http://127.0.0.1:8765/health`
- cron voice sidecar health: `http://127.0.0.1:8786/health`

Always detect actual paths first; do not assume everything exists.

## Safe Inspection Checklist
1. Check `openclaw gateway health`.
2. Read `~/.openclaw/openclaw.json` if present.
3. Check TTS `/health`.
4. Check launchd service presence for gateway, local TTS, and cron voice sidecar.
5. Inspect `cron/jobs.json` only if the request involves scheduled delivery.

## Mutation Checklist
1. Back up config before changing it.
2. Change the smallest viable surface.
3. Restart only the services affected by the change.
4. Re-run health checks.
5. Record the exact files changed for rollback.
