#!/bin/bash

WATCH_DIR="${1:-.}"
LOG_FILE=".file_monitor.log"

if [[ "$1" == "--undo" ]]; then
  while IFS='|' read -r OLD NEW; do
    mkdir -p "$(dirname "$OLD")"
    mv "$NEW" "$OLD"
  done < "$LOG_FILE"
  rm -f "$LOG_FILE"
  echo "✅ Recovery completed."
  exit 0
fi

echo "📡 Monitoring folder: $WATCH_DIR"

inotifywait -m -e create --format '%f' "$WATCH_DIR" | while read FILE
do
  [[ -d "$WATCH_DIR/$FILE" ]] && continue
  echo "$(date) | Detected: $FILE" >> "$LOG_FILE"
  ./organize.sh "$WATCH_DIR"
done
