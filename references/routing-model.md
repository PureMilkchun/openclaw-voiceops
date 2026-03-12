# Routing Model

## Principle
Voice routing is based on original task intent, not on job category.

## Positive Voice Signals
Treat a task as voice-intent when its original prompt or summary explicitly asks for voice behavior, for example:
- `语音提醒`
- `语音消息`
- `可直接朗读`
- `报平安`
- existing `[[tts:...]]` markers
- obvious English equivalents such as `voice message` or `read aloud`

## Negative Signals
Keep tasks as text when they are only:
- informative digests
- research/news nudges without explicit voice intent
- maintenance notifications
- status summaries
- generic cron jobs with no speech requirement

## Correct Examples
- Calendar reminder asking for a spoken reminder: voice.
- Heartbeat prompt asking for a brief spoken check-in: voice.
- AI roundup asking only for a short update: text unless explicitly voice.

## Incorrect Examples
- Turning every `cron` job into voice.
- Converting a text-only update because the user likes voice in another workflow.
- Replaying stale text deliveries after a routing change.

## Recovery Rules
When text+voice duplicates appear:
1. Inspect recent cron runs and delivery logs.
2. Check `~/.openclaw/delivery-queue` for stale text deliveries.
3. Remove only queued text payloads that target Telegram and still contain TTS-tagged text.
4. Do not clear unrelated failed deliveries.
5. Re-check whether the underlying job prompt still encodes explicit voice intent.
