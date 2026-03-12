# Runbook Template

Use this structure when the user wants a non-technical operating guide.

## Minimal Runbook
1. Check OpenClaw: `openclaw gateway health`
2. Restart OpenClaw if needed: `openclaw gateway restart`
3. Check local TTS: `curl http://127.0.0.1:8765/health`
4. Check cron voice sidecar: `curl http://127.0.0.1:8786/health`
5. If still broken, collect the three primary logs:
   - gateway log
   - cron voice log
   - local TTS log

## Tone
- short
- non-judgmental
- no internal implementation jargon unless requested
