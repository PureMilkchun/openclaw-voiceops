#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-}"
if [ -z "$TARGET" ]; then
  echo 'usage: safe_rollback.sh <backup-file>'
  exit 2
fi
BACKUP="$TARGET"
if [ ! -f "$BACKUP" ]; then
  echo 'backup_missing'
  exit 1
fi
BASENAME="$(basename "$BACKUP")"
RESTORE_DIR="$(dirname "$BACKUP")"
case "$BASENAME" in
  openclaw.json.bak*) DEST="$RESTORE_DIR/openclaw.json" ;;
  jobs.json.bak*|jobs.json.bak_*) DEST="$RESTORE_DIR/jobs.json" ;;
  *.plist.bak*) DEST="$RESTORE_DIR/${BASENAME%%.bak*}" ;;
  *) echo 'unsupported_backup_name'; exit 1 ;;
esac
cp "$BACKUP" "$DEST"
echo "restored=$DEST"
if command -v openclaw >/dev/null 2>&1 && [[ "$DEST" == *"openclaw.json" || "$DEST" == *"jobs.json" ]]; then
  openclaw gateway restart || true
fi
