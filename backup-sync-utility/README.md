# 💾 Backup & Sync Utility (Bash + rsync)

A **Linux-based Bash utility** to safely backup and sync folders with logging, versioning, and optional dry-run mode.  

Designed for **developers, sysadmins, and power users**.

---

## ✨ Features

- Timestamped backup of directories
- Safe sync between source and destination
- Dry-run mode to verify changes
- Logging every action to `.backup.log`
- Exclude files by type or pattern
- Works recursively

---

## 📂 Folder Structure

```text
backup-sync-utility/
├── README.md
├── docs/
│   └── design.md
└── src/
    ├── backup.sh
    └── sync.sh
