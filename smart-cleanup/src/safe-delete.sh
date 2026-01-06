#!/bin/bash

TRASH=".trash"
LOG="$TRASH/trash.log"

mkdir -p "$TRASH"

while read -r FILE; do
  [[ -f "$FILE" ]] || continue

  DEST="$TRASH/$(basename "$FILE").$(date +%s)"
  echo "$FILE|$DEST" >> "$LOG"
  mv "$FILE" "$DEST"
done < .duplicates.list

echo "🗑 Files moved to trash safely."
