#!/usr/bin/env bash
set -euo pipefail
MODE="${1:-inspect}"
OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
CONFIG="$OPENCLAW_HOME/openclaw.json"
TTS_BASE_URL="${TTS_BASE_URL:-http://127.0.0.1:8765/v1}"
if [ "$MODE" = "inspect" ]; then
  python3 - <<PY
import json, pathlib
p=pathlib.Path('$CONFIG')
if not p.exists():
    print('config_missing')
else:
    data=json.loads(p.read_text())
    print(json.dumps(data.get('messages', {}).get('tts', {}), ensure_ascii=False, indent=2))
PY
  exit 0
fi
if [ "$MODE" != "apply" ]; then
  echo 'usage: wire_telegram_voice.sh [inspect|apply]'
  exit 2
fi
python3 - <<PY
import json, pathlib, shutil, time
p=pathlib.Path('$CONFIG')
if not p.exists():
    raise SystemExit('config_missing')
backup=p.with_name(f'openclaw.json.bak_wire_telegram_voice_{int(time.time())}')
shutil.copy2(p, backup)
data=json.loads(p.read_text())
messages=data.setdefault('messages', {})
tts=messages.setdefault('tts', {})
tts['auto']='always'
tts['mode']='final'
tts['provider']='openai'
openai=tts.setdefault('openai', {})
openai['apiKey']='local-qwen-tts'
openai['baseUrl']='$TTS_BASE_URL'
openai['model']=openai.get('model', 'qwen3-tts-1.7b')
openai['voice']=openai.get('voice', 'default')
edge=tts.setdefault('edge', {})
edge['enabled']=False
p.write_text(json.dumps(data, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
print(f'backup={backup}')
print('updated=openclaw_tts')
PY
openclaw gateway restart || true
