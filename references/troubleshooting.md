# Troubleshooting

## High-Signal Commands
- `openclaw gateway health`
- `curl http://127.0.0.1:8765/health`
- `curl http://127.0.0.1:8786/health`
- `launchctl list | rg 'openclaw|qwen|tts'`

## High-Signal Logs
- `/tmp/openclaw/openclaw-YYYY-MM-DD.log`
- `~/.openclaw/logs/cron-voice-delivery.log`
- `/tmp/local-qwen-tts.err.log`
- `~/.openclaw/logs/gateway-debug.jsonl`

## Failure Buckets
### Telegram polling / VPN / proxy
Symptoms:
- `Telegram: configured`
- polling stall
- send failures during network changes

Actions:
1. Check gateway health.
2. Restart gateway only if Telegram is not `ok`.
3. Confirm proxy settings before changing TTS.

### Local TTS unavailable
Symptoms:
- no response from `127.0.0.1:8765`
- speech request timeouts

Actions:
1. Check TTS `/health`.
2. Check launchd status.
3. Inspect TTS stderr log.

### Text + voice duplicates
Symptoms:
- Telegram shows TTS-tagged text plus a voice message below it

Actions:
1. Inspect recent cron runs.
2. Check delivery recovery logs.
3. Clear only stale queued text deliveries.
4. Verify routing intent for the affected job.

## Restart Order
Use the minimum restart order:
1. `openclaw gateway restart`
2. local TTS service only if its health endpoint is down
3. cron voice sidecar only if routing/logging is broken
