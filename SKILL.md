---
name: openclaw-voiceops
description: Deploy, inspect, repair, harden, and customize an OpenClaw + local Qwen TTS + Telegram stack on Apple Silicon Macs. Use when working on OpenClaw local gateway setup, Telegram pairing/OAuth follow-through, local Qwen3-TTS bring-up, TTS routing, cron voice delivery, reference-voice workflows, VPN/proxy instability, diagnostics collection, rollback planning, or non-technical runbook generation for Codex, Claude Code, or OpenCode users.
---

# OpenClaw VoiceOps

Use a layered workflow.

1. Start in `safe inspection` mode unless the user clearly asked for mutation.
2. Announce the mode before running anything substantial.
3. Read only the reference file needed for the current task.
4. Prefer bundled scripts over ad-hoc shell when a script already covers the job.
5. Before mutation, create backups and state what will change.
6. Never do destructive resets or broad cleanup without explicit confirmation.

## Workflow Router

### 1. Inspect First
Use these modules first for most requests:
- `bootstrap-openclaw`: detect OpenClaw install, paths, gateway health. Use [deployment-model.md](./references/deployment-model.md) and `scripts/bootstrap_openclaw.sh`.
- `bootstrap-local-tts`: detect local Qwen TTS service, `/health`, launchd status, model defaults. Use [deployment-model.md](./references/deployment-model.md) and `scripts/bootstrap_local_tts.sh`.
- `collect-diagnostics`: gather only high-signal logs and health snapshots. Use [troubleshooting.md](./references/troubleshooting.md) and `scripts/collect_diagnostics.sh`.

### 2. Mutate Only On Explicit Request
Use these modules only after the user asks to apply or fix:
- `wire-telegram-voice`: wire OpenClaw Telegram voice output to local TTS, proxy-aware. Use [troubleshooting.md](./references/troubleshooting.md) and `scripts/wire_telegram_voice.sh`.
- `cron-voice-routing`: enforce intent-based routing for cron jobs and prevent stale text replay. Use [routing-model.md](./references/routing-model.md) and `scripts/cron_voice_routing.py`.
- `network-recovery`: recover from VPN/proxy/polling issues with the minimum restart order. Use [troubleshooting.md](./references/troubleshooting.md).
- `safe-rollback`: restore last-known-good config, launchd plists, and routing state. Use [safety-model.md](./references/safety-model.md) and `scripts/safe_rollback.sh`.

### 3. Customization Tasks
- Reference-voice catgirl workflows: use [reference-voice-workflow.md](./references/reference-voice-workflow.md).
- Runbook generation for end users: use [runbook-template.md](./references/runbook-template.md).
- Cross-agent adaptation notes: use [agent-compat.md](./references/agent-compat.md).

## Decision Rules

### Safe Inspection Mode
Do this by default:
- read configs
- inspect launchd status
- check gateway/TTS health
- collect logs
- detect drift
- explain the likely fix before changing anything

### Mutation Mode
Do this only when explicitly requested:
- patch `~/.openclaw/*`
- patch cron routing or delivery behavior
- patch local TTS config
- write/update launchd plists
- restart services
- clear stale queued text deliveries
- backfill missed voice runs

## Routing Rules

Treat voice delivery as an intent problem, not a job-category problem.

Voice intent includes tasks that explicitly ask for:
- `语音提醒`
- `语音消息`
- `可直接朗读`
- `报平安`
- existing `[[tts:...]]` summaries

Do not convert non-voice cron jobs into voice just because they are scheduled. Read [routing-model.md](./references/routing-model.md) before changing cron behavior.

## Supported Scope

Supported:
- Apple Silicon Mac mini
- OpenClaw local gateway
- Telegram channel
- local Qwen3-TTS service on Apple Silicon
- cron voice routing and recovery
- proxy/VPN diagnosis
- safe rollback

Defer or reject:
- Linux/CUDA-only Qwen instructions
- unsupported chat channels unless documented locally
- destructive resets without confirmation
- training, finetuning, or model tuning pipelines
