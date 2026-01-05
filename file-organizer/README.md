# 📂 File Organizer (Bash Utility)

A safe, production-ready **Bash-based file organizer** that automatically sorts files into folders based on file type.  
Includes **undo/recovery**, **real-time monitoring**, and **USB auto-detection support**.

This tool is designed for **daily Linux usage**, not demos.

---

## ✨ Features

### Core Features
- Automatically organizes files by type
- Creates folders only when needed
- Never moves directories
- Works on any folder
- Uses only standard Linux tools

### Safety & Recovery
- Logs every file move
- Full undo / recovery support
- No overwrite by default
- Designed to prevent data loss

### Advanced Automation
- Real-time folder monitoring (event-driven)
- USB auto-detection using udev
- Background-friendly scripts

---

## 📂 Folder Structure

file-organizer/
├── README.md
├── docs/
│ ├── monitor-design.md
│ └── usb-auto-detection.md
└── src/
├── organize.sh
├── monitor-organize.sh
└── usb-auto-organize.sh

yaml
Copy code

---

## 🗂 Supported File Categories

| Category | Extensions |
|-------|-----------|
| Videos | mp4, mkv, avi, mov, flv |
| Images | jpg, jpeg, png, gif, bmp, webp |
| Audio | mp3, wav, flac, aac |
| Documents | pdf, doc, docx, txt, xls, xlsx, ppt, pptx |
| Archives | zip, tar, gz, rar, 7z |
| Scripts | sh, py, js, java, c, cpp |
| Others | Any unknown file types |

You can easily extend this list inside the script.

---

## ⚙️ Prerequisites

- Linux system
- Bash 4+
- Git
- For monitoring features:
```bash
sudo apt install inotify-tools```

##organize.sh — File Organizer
Make Executable (once)
```cd file-organizer/src
chmod +x organize.sh```

##Organize Current Folder
./organize.sh

##Organize a Specific Folder
./organize.sh /path/to/target-folder

##Undo/Recovery
```./organize.sh --undo```

- Restores all files to original locations
- Uses .file_organizer.log
- Log is removed after successful recovery
monitor-organize.sh — Real-Time Folder Monitor

Automatically organizes files the moment they appear.

##Use Cases

Downloads folder
Incoming shared folders
Continuous cleanup

###Usage
chmod +x monitor-organize.sh
./monitor-organize.sh ~/Downloads

🔄 Undo
./monitor-organize.sh --undo


##Design details:

docs/monitor-design.md

🔌 usb-auto-organize.sh — USB Auto Organization

Automatically organizes files when a USB device is plugged in.

##Technology Used

- Linux udev
- Kernel-level hardware events
- Absolute-path Bash execution

##Setup Summary

####Create udev rule:
sudo nano /etc/udev/rules.d/99-usb-auto-organize.rules

- Add:
ACTION=="add", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", RUN+="/absolute/path/usb-auto-organize.sh %k"


####Reload rules:
sudo udevadm control --reload-rules
sudo udevadm trigger

- Logs:
sudo cat /var/log/usb-auto-organizer.log


###Design details:

docs/usb-auto-detection.md

###Safety Principles

- Directories are never moved
- Files are never overwritten silently
- Every action is logged
- Undo is always possible
- Absolute paths enforced for system scripts
