#!/bin/bash

LOG_FILE="logs/actions.log"

tac "$LOG_FILE" | while IFS='|' read -r SRC DEST; do
  [ -f "$DEST" ] && mv "$DEST" "$SRC"
done

> "$LOG_FILE"
