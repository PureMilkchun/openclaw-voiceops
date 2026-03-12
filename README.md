# OpenClaw VoiceOps

[![Validate](https://github.com/PureMilkchun/openclaw-voiceops/actions/workflows/validate.yml/badge.svg)](https://github.com/PureMilkchun/openclaw-voiceops/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/PureMilkchun/openclaw-voiceops/blob/main/LICENSE)

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

### Install Paths
- Codex: `$CODEX_HOME/skills/openclaw-voiceops`
- Claude Code: your local Claude Code skills directory
- OpenCode: your local OpenCode skills/extensions directory

## Quick Start
1. Clone or download this repository.
2. Place `openclaw-voiceops` into your agent's skills directory.
3. Ask your agent to use `$openclaw-voiceops` for one of these tasks:
   - inspect an existing OpenClaw voice stack
   - deploy local Qwen TTS on Apple Silicon
   - repair Telegram voice routing
   - diagnose cron text/voice duplication

### Example Prompts
- `Use $openclaw-voiceops to inspect my OpenClaw + Telegram + local Qwen TTS setup on this Mac mini.`
- `Use $openclaw-voiceops to switch Telegram voice output to my local Qwen TTS service.`
- `Use $openclaw-voiceops to diagnose why my scheduled voice jobs are duplicating text and voice.`
- `Use $openclaw-voiceops to generate a simple runbook for my OpenClaw setup.`

This repository keeps one canonical workflow and does not maintain three divergent implementations.

## CI
GitHub Actions validates:
- shell syntax for `scripts/*.sh`
- Python syntax for `scripts/*.py`
- presence and basic shape of skill metadata

## Validation
This skill was validated with:
- shell script syntax checks
- Python syntax checks
- the Codex `quick_validate.py` skill validator

## Repository Goals
- Make Apple Silicon OpenClaw voice stacks reproducible
- Encode safe inspection-first agent operations
- Package real-world routing, recovery, and rollback workflows into reusable assets
- Reduce the amount of one-off shell debugging needed to get a local voice assistant working

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

### 安装
#### Codex
把 `openclaw-voiceops` 放到 `$CODEX_HOME/skills/openclaw-voiceops`。

#### Claude Code
放到你本地的 Claude Code skills 目录，再按当前工作流显式调用。

#### OpenCode
放到 OpenCode 使用的 skills/extensions 目录，再在提示词中显式启用。

#### 推荐安装路径
- Codex：`$CODEX_HOME/skills/openclaw-voiceops`
- Claude Code：本地 Claude Code skills 目录
- OpenCode：本地 OpenCode skills/extensions 目录

### 快速开始
1. 克隆或下载本仓库。
2. 把 `openclaw-voiceops` 目录放进你的代理 skills 目录。
3. 让代理用 `$openclaw-voiceops` 执行如下任务之一：
   - 检查现有 OpenClaw 语音栈
   - 在 Apple Silicon 上部署本地 Qwen TTS
   - 修复 Telegram 语音路由
   - 排查 cron 文本/语音重复问题

### 示例提示词
- `Use $openclaw-voiceops to inspect my OpenClaw + Telegram + local Qwen TTS setup on this Mac mini.`
- `Use $openclaw-voiceops to switch Telegram voice output to my local Qwen TTS service.`
- `Use $openclaw-voiceops to diagnose why my scheduled voice jobs are duplicating text and voice.`
- `Use $openclaw-voiceops to generate a simple runbook for my OpenClaw setup.`

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

### 仓库目标
- 让 Apple Silicon 上的 OpenClaw 语音栈可复现
- 把“先检查再修复”的 agent 运维方式固化下来
- 把真实踩坑得到的路由、恢复、回滚流程沉淀成可复用资源
- 减少每次部署时重复写脚本和重复排障的成本

### 不包含的范围
- Linux / CUDA 为主的部署方案
- 未文档化的聊天通道
- 未经确认的破坏性重置
- 训练、微调、finetune 流程
