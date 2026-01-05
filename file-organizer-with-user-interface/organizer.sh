#!/bin/bash

TARGET_DIR="$1"
LOG_FILE="logs/actions.log"

mkdir -p "$TARGET_DIR"/{Images,Videos,Documents,Audio,Archives}

for file in "$TARGET_DIR"/*; do
  [ -f "$file" ] || continue

  EXT="${file##*.}"
  DEST=""

  case "$EXT" in
    jpg|png|jpeg|gif) DEST="Images" ;;
    mp4|mkv|avi) DEST="Videos" ;;
    mp3|wav) DEST="Audio" ;;
    pdf|docx|txt) DEST="Documents" ;;
    zip|tar|gz) DEST="Archives" ;;
    *) continue ;;
  esac

  echo "$file|$TARGET_DIR/$DEST/$(basename "$file")" >> "$LOG_FILE"
  mv "$file" "$TARGET_DIR/$DEST/"
done
