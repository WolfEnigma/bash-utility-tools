# Folder Monitor & Auto Organizer — Design Document

## 1. Overview

The Folder Monitor & Auto Organizer is a Bash-based system utility designed to **continuously watch a directory** and **automatically organize files as soon as they appear**.

It is intended for real-world use cases such as:
- USB drive insertion
- Downloads folder cleanup
- Shared directories
- Server-side file ingestion pipelines

The design emphasizes **safety, recoverability, and low system overhead**.

---

## 2. Design Goals

- **Real-time operation** (event-driven, not polling)
- **Minimal dependencies**
- **Safe file operations**
- **Full recovery support**
- **Portable across Linux systems**
- **Readable and maintainable Bash code**

---

## 3. System Architecture

+------------------+
| File System Event|
| (inotify) |
+--------+---------+
|
v
+------------------+
| monitor-organize |
| (listener) |
+--------+---------+
|
v
+------------------+
| organize.sh |
| (file classifier)|
+--------+---------+
|
v
+------------------+
| Organized Folders|
+------------------+

yaml
Copy code

---

## 4. Core Components

### 4.1 monitor-organize.sh

**Responsibilities:**
- Watches a target directory using `inotifywait`
- Detects file creation events
- Ignores directories
- Triggers organization logic
- Records actions for recovery

**Key Design Choices:**
- Uses `-m` (monitor mode) for continuous listening
- Uses `create` event only (low overhead)
- Delegates logic to `organize.sh` (single responsibility principle)

---

### 4.2 organize.sh

**Responsibilities:**
- Classifies files by extension
- Creates destination folders
- Moves files safely
- Logs original locations

This separation allows:
- Reuse of `organize.sh`
- Easier testing
- Cleaner recovery logic

---

## 5. Event Handling Strategy

The tool uses **Linux inotify events**, which are:
- Kernel-level
- Instant
- Resource efficient

Compared to polling (`sleep` loops), this approach:
- Uses less CPU
- Responds immediately
- Scales better

---

## 6. Logging & Recovery Design

### 6.1 Log File Format

ORIGINAL_PATH|NEW_PATH

makefile
Copy code

Example:
/home/user/Downloads/file.jpg|/home/user/Downloads/Images/file.jpg

yaml
Copy code

### 6.2 Recovery Flow

1. Read log file line by line
2. Recreate original directories if missing
3. Move files back to original locations
4. Delete log after successful restore

This ensures **lossless recovery**.

---

## 7. Safety Considerations

- Directories are never moved
- Existing files are not overwritten
- Log file enables full rollback
- Script exits cleanly on failure
- `trap` can be extended for signal handling

---

## 8. Error Handling Strategy

| Scenario | Behavior |
|-------|---------|
| No files found | No-op |
| Folder missing | Exit with message |
| Permission denied | Skip and log |
| Script interruption | Logged operations preserved |

---

## 9. Extensibility

The design allows easy extension:
- Add new file types in one place
- Plug in new organizer modules
- Integrate cron or systemd services
- Add notifications or alerts

---

## 10. Limitations

- Linux-only (requires inotify)
- Does not monitor file modifications
- Large batch arrivals may trigger multiple runs

These are acceptable trade-offs for simplicity and reliability.

---

## 11. Future Improvements

- Systemd service support
- Recursive directory monitoring
- Config file support (`.conf`)
- Dry-run mode
- Email / desktop notifications

---

## 12. Conclusion

This tool demonstrates:
- Practical Bash engineering
- Event-driven automation
- Production-safe file handling
- Clear separation of concerns

It is designed not as a demo, but as a **usable system utility**.


