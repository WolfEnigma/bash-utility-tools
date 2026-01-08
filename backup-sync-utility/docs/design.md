# 📐 Backup & Sync Utility – Design Document

## 🎯 Goals
- Backup source directories safely
- Sync folders efficiently
- Maintain logs and timestamps
- Prevent accidental deletion

## 🧠 Design Principles
- Read-only operations where possible
- Every destructive operation logged
- Dry-run mode before actual sync
- Modular scripts: backup.sh & sync.sh

## 🔁 Workflow

### backup.sh
1. Accept source and destination
2. Create timestamped folder in destination
3. Copy files recursively
4. Log each file copied

### sync.sh
1. Accept source and destination
2. Compare files using `rsync`
3. Copy updated files only
4. Optional `--dry-run` to preview
5. Log changes

## 🔐 Safety
- No directories are deleted without explicit confirmation
- Logging enables recovery
- Timestamped backups prevent overwriting
