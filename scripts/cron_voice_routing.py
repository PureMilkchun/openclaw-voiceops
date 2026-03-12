#!/usr/bin/env python3
import argparse
import json
import shutil
import time
from pathlib import Path

VOICE_HINTS = ('语音', '朗读', '可直接朗读', '语音提醒', '语音消息', '报平安', 'voice')


def implies_voice(text: str) -> bool:
    lowered = text.lower()
    return any(h.lower() in lowered for h in VOICE_HINTS)


def normalize_prompt(text: str) -> str:
    out = text
    out = out.replace('回复必须包含 [[tts:playful]] 和 [[tts:text]]...[[/tts:text]]，按严格语音方式发送。', '请只输出自然、可直接朗读的中文，不要输出任何标签或标记符号。')
    out = out.replace('回复必须包含 [[tts:gentle]] 和 [[tts:text]]...[[/tts:text]]，按严格语音方式发送。', '请只输出自然、可直接朗读的中文，不要输出任何标签或标记符号。')
    out = out.replace('必须包含 [[tts:playful]] 和 [[tts:text]]...[[/tts:text]]。', '只输出自然、可直接朗读的中文，不要输出任何标签或标记符号。')
    out = out.replace('必须包含 [[tts:gentle]] 和 [[tts:text]]...[[/tts:text]]。', '只输出自然、可直接朗读的中文，不要输出任何标签或标记符号。')
    return out


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument('--jobs', default=str(Path.home() / '.openclaw/cron/jobs.json'))
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    path = Path(args.jobs)
    if not path.exists():
        print('jobs_missing')
        return 1
    data = json.loads(path.read_text(encoding='utf-8'))
    changed = 0
    voice_jobs = []
    text_jobs = []
    for job in data.get('jobs', []):
        msg = str(job.get('payload', {}).get('message') or '')
        voice = implies_voice(msg)
        (voice_jobs if voice else text_jobs).append(job.get('name'))
        if voice:
            delivery = job.setdefault('delivery', {})
            if delivery.get('mode') != 'none':
                delivery.clear()
                delivery['mode'] = 'none'
                changed += 1
        normalized = normalize_prompt(msg)
        if normalized != msg:
            job.setdefault('payload', {})['message'] = normalized
            changed += 1
    print(json.dumps({'voice_jobs': voice_jobs, 'text_jobs': text_jobs, 'changed': changed}, ensure_ascii=False, indent=2))
    if args.apply and changed:
        backup = path.with_name(f'{path.name}.bak_routing_{int(time.time())}')
        shutil.copy2(path, backup)
        path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
        print(f'backup={backup}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
