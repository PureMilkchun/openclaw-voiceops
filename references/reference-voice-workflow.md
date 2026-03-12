# Reference Voice Workflow

## Goal
Use a reference voice sample to steer local TTS toward a stable persona, such as a catgirl voice, without changing the core deployment model.

## Preferred Flow
1. Place a clean reference sample in a dedicated voice folder.
2. Start with reference-only cloning or prompting.
3. Compare multiple short generations with the same sentence.
4. Promote the selected reference into the default TTS config only after listening tests.

## Sample Quality Rules
- 5-15 seconds is preferred
- single speaker only
- no background music
- low reverb
- stable emotion and speaking speed

## Practical Notes
- instruction-only style control improves tone but not stable identity
- `ref_audio + ref_text` is stronger than instruction-only when supported
- short references can work, but identity drift is more likely on long utterances
