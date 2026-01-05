#!/bin/bash

DEVICE="$1"
LOG="/var/log/usb-auto-organizer.log"

sleep 2  # wait for mount

MOUNT_POINT=$(lsblk -o NAME,MOUNTPOINT | grep "$DEVICE" | awk '{print $2}')

if [[ -z "$MOUNT_POINT" ]]; then
  echo "$(date) | No mount point for $DEVICE" >> "$LOG"
  exit 0
fi

echo "$(date) | USB detected at $MOUNT_POINT" >> "$LOG"

# Run organizer
/path/to/bash-utility-tools/file-organizer/src/organize.sh "$MOUNT_POINT"
