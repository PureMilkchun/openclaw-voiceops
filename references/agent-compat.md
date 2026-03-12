# Agent Compatibility

## Canonical Skill
This is one canonical skill for three coding agents:
- Codex
- Claude Code
- OpenCode

## Preferred Baseline
Treat Codex as the reference implementation for wording, scripts, and workflow order.

## Adaptation Notes
### Codex
- best default fit
- can follow the skill structure directly
- use bundled scripts first

### Claude Code
- keep prompts explicit about safe inspection vs mutation mode
- prefer short operational summaries before shell actions
- use the same bundled scripts; do not fork the workflow

### OpenCode
- prefer shell-first invocation patterns
- keep script inputs explicit through env vars and flags
- avoid relying on Codex-specific UI assumptions

## Rule
Do not create three divergent procedures. Keep one operational workflow and adjust only the framing and invocation style.
