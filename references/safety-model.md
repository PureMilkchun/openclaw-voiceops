# Safety Model

## Default Posture
Safe by default. Inspect first, mutate only on explicit request.

## Before Mutation
- create a timestamped backup for every config file changed
- announce which files will change
- avoid destructive commands such as broad `rm`, reset, or token rotation unless explicitly requested

## Rollback Scope
Rollback should be able to restore:
- `~/.openclaw/openclaw.json`
- `~/.openclaw/cron/jobs.json`
- any launchd plist written by the workflow
- any sidecar script copies managed by the workflow

## Rollback Order
1. stop or restart the affected sidecar/service
2. restore the backed-up file
3. reload launchd if plist changed
4. restart OpenClaw gateway if OpenClaw config or cron state changed
5. rerun health checks

## Never Assume
- never invent missing secret paths
- never assume tokens can be regenerated locally
- never clear the whole delivery queue unless the user explicitly asks
