#!/bin/bash
# ================================
# Sync Script (uses rsync)
# Usage: ./sync.sh /source/folder /destination/folder [--dry-run]
# ================================

SOURCE="$1"
DEST="$2"
DRY_RUN="$3"
LOG_FILE="$DEST/.backup.log"

if [[ -z "$SOURCE" || -z "$DEST" ]]; then
  echo "Usage: $0 /source/folder /destination/folder [--dry-run]"
  exit 1
fi

RSYNC_OPTS="-avh --progress"
[[ "$DRY_RUN" == "--dry-run" ]] && RSYNC_OPTS="$RSYNC_OPTS --dry-run"

echo "Sync started: $(date)" >> "$LOG_FILE"
echo "Source: $SOURCE" >> "$LOG_FILE"
echo "Destination: $DEST" >> "$LOG_FILE"

rsync $RSYNC_OPTS "$SOURCE/" "$DEST/"

echo "Sync completed: $(date)" >> "$LOG_FILE"
