#!/bin/bash

# ================================
# File Organizer Tool (with Recovery)
# Automatically organizes files by type
# Supports undo (--undo)
# ================================

LOG_FILE=".file_organizer.log"

# Enable nullglob (prevents errors if no files found)
shopt -s nullglob

# ----------------
# UNDO MODE
# ----------------
if [[ "$1" == "--undo" ]]; then
  if [[ ! -f "$LOG_FILE" ]]; then
    echo "❌ No log file found. Nothing to undo."
    exit 1
  fi

  while IFS="|" read -r ORIGINAL NEW; do
    mkdir -p "$(dirname "$ORIGINAL")"
    mv "$NEW" "$ORIGINAL"
  done < "$LOG_FILE"

  rm "$LOG_FILE"
  echo "🔄 Recovery completed. Files restored."
  exit 0
fi

# Clear or create log file
> "$LOG_FILE"

# Declare file type groups
declare -A FILE_TYPES=(
  ["Videos"]="mp4 mkv avi mov flv"
  ["Images"]="jpg jpeg png gif bmp webp"
  ["Audio"]="mp3 wav flac aac"
  ["Documents"]="pdf doc docx txt xls xlsx ppt pptx"
  ["Archives"]="zip tar gz rar 7z"
  ["Scripts"]="sh py js java c cpp"
)

# Create folders if they don't exist
for folder in "${!FILE_TYPES[@]}"; do
  mkdir -p "$folder"
done

mkdir -p Others

# Move files based on extension
for file in *.*; do
  moved=false
  ext="${file##*.}"

  for folder in "${!FILE_TYPES[@]}"; do
    for type in ${FILE_TYPES[$folder]}; do
      if [[ "$ext" == "$type" ]]; then
        echo "$(pwd)/$file|$(pwd)/$folder/$file" >> "$LOG_FILE"
        mv "$file" "$folder/"
        moved=true
        break
      fi
    done
    $moved && break
  done

  if [ "$moved" = false ]; then
    echo "$(pwd)/$file|$(pwd)/Others/$file" >> "$LOG_FILE"
    mv "$file" Others/
  fi
done

echo "✅ Files organized successfully."
echo "↩ Run './organize.sh --undo' to restore files."

