# OpenClaw VoiceOps

English | [中文](#中文说明)

A cross-agent skill pack for `Codex`, `Claude Code`, and `OpenCode` to deploy, inspect, repair, and customize an `OpenClaw + local Qwen TTS + Telegram` stack on Apple Silicon Macs.

This skill is based on a real Apple Silicon Mac mini workflow and is opinionated around:
- OpenClaw local gateway
- Telegram as the primary channel
- Local Qwen3-TTS service on macOS
- Intent-based cron voice routing
- Strong diagnostics and rollback paths

## What This Skill Does
- Inspect OpenClaw install, config, health, and launchd state
- Inspect local Qwen TTS and cron voice sidecar health
- Wire Telegram voice output to a local TTS service
- Diagnose VPN/proxy/Telegram instability
- Enforce intent-based cron voice routing
- Clear stale text-delivery replay issues safely
- Guide reference-voice customization workflows
- Generate a simple end-user runbook

## Safety Model
This skill is **safe by default**.

Default behavior:
1. Inspect first
2. Explain likely fixes
3. Mutate only when explicitly asked

The bundled scripts are designed to help an agent work systematically, but they should not be used as blind automation without understanding the current machine state.

## Layout
- `SKILL.md`: main skill instructions and routing logic
- `agents/openai.yaml`: Codex-compatible metadata
- `references/`: operational references and policies
- `scripts/`: helper scripts for inspection, repair, routing, rollback, and runbook generation

## Included Modules
- `bootstrap-openclaw`
- `bootstrap-local-tts`
- `collect-diagnostics`
- `wire-telegram-voice`
- `cron-voice-routing`
- `network-recovery`
- `safe-rollback`
- `runbook-generation`

## Installation
### Codex
Copy this folder into your skill location, for example under `$CODEX_HOME/skills/`.

### Claude Code / OpenCode
Install this folder in the agent's local skills/extensions directory, then invoke it explicitly in prompts using the skill name or your tool's equivalent skill mechanism.

## Validation
This skill was validated with:
- shell script syntax checks
- Python syntax checks
- the Codex `quick_validate.py` skill validator

## Notes
- This repository does not include secrets, tokens, personal chat IDs, or machine-specific usernames.
- It assumes Apple Silicon macOS as the primary target.
- It intentionally does not cover Linux/CUDA-first deployment paths.

## 中文说明
这是一个面向 `Codex`、`Claude Code`、`OpenCode` 的跨代理 skill 包，用来在 Apple Silicon Mac 上部署、检查、修复和魔改 `OpenClaw + 本地 Qwen TTS + Telegram` 语音栈。

这套 skill 基于真实的 Mac mini 工作流整理，重点覆盖：
- OpenClaw 本地网关
- Telegram 主通道
- macOS 本地 Qwen3-TTS
- 按“原始任务意图”进行 cron 语音路由
- 强诊断能力与可回滚能力

### 这个 Skill 能做什么
- 检查 OpenClaw 安装、配置、健康状态、launchd 状态
- 检查本地 Qwen TTS 与 cron 语音 sidecar 健康状态
- 把 Telegram 语音输出切到本地 TTS
- 排查 VPN / 代理 / Telegram 不稳定问题
- 修正 cron 语音路由，避免“所有定时任务都变语音”
- 安全清理旧的文本重放问题
- 支持参考音频的人设语音流程
- 生成给普通用户看的简易 runbook

### 安全模型
这套 skill 默认遵循“先检查，后改动”。

默认流程：
1. 先检查
2. 先解释问题和修复方向
3. 只有在用户明确要求时才执行改动

### 目录说明
- `SKILL.md`：skill 主入口
- `agents/openai.yaml`：Codex 元数据
- `references/`：运维、路由、安全、排障参考资料
- `scripts/`：检查、修复、回滚、runbook 生成脚本

### 适用范围
- 主要目标机器：Apple Silicon Mac mini
- 主要编排层：OpenClaw
- 主通道：Telegram
- 本地语音：Qwen3-TTS 路线

### 不包含的范围
- Linux / CUDA 为主的部署方案
- 未文档化的聊天通道
- 未经确认的破坏性重置
- 训练、微调、finetune 流程
