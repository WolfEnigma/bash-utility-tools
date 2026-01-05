# USB Auto-Detection & Auto File Organization

## Overview

This component enables **automatic detection of USB storage devices** and triggers the file organizer **immediately when a USB is inserted**.

It uses **Linux udev rules**, allowing the system to respond to **hardware events at kernel level**, without polling, cron jobs, or manual execution.

This design is suitable for:
- USB drives
- External hard disks
- SD cards
- Removable storage devices

---

## How It Works

USB Inserted
↓
Kernel detects block device
↓
udev rule triggered
↓
usb-auto-organize.sh executed
↓
Mount point resolved
↓
File organizer runs automatically

yaml
Copy code

This is a **true event-driven automation pipeline**.

---

## Components

### 1. udev Rule

The udev rule listens for USB partition additions and executes a Bash script.

File:
/etc/udev/rules.d/99-usb-auto-organize.rules

makefile
Copy code

Rule:
```text
ACTION=="add", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", RUN+="/absolute/path/usb-auto-organize.sh %k"
Key points:

ACTION=="add" → device insertion

SUBSYSTEM=="block" → storage devices

DEVTYPE=="partition" → avoids raw disks

%k → kernel device name (e.g., sdb1)

2. usb-auto-organize.sh
This script:

Receives the device name from udev

Resolves the mount point

Executes the organizer on that mount

Logs all activity for auditing

Simplified flow:

Wait for mount completion

Detect mount point using lsblk

Execute organize.sh

Log actions

Absolute paths are mandatory because udev does not load user environments.

Logging
All USB events are logged to:

lua
Copy code
/var/log/usb-auto-organizer.log
Example log:

bash
Copy code
2026-01-06 10:21:45 | USB detected at /media/user/USB_DRIVE
Logs assist in:

Debugging

Auditing

Incident analysis

Security Considerations
Risk	Mitigation
Accidental execution	Root-controlled udev rules
File overwrite	Organizer avoids directories
Data loss	Undo/recovery supported
Script abuse	Absolute paths enforced

This design follows least-surprise and least-risk principles.

Testing & Debugging
Reload udev rules
bash
Copy code
sudo udevadm control --reload-rules
sudo udevadm trigger
Monitor udev events (debug)
bash
Copy code
udevadm monitor --udev
Check logs
bash
Copy code
sudo tail -f /var/log/usb-auto-organizer.log
Disabling the Feature
To temporarily disable USB auto-organization:

bash
Copy code
sudo mv /etc/udev/rules.d/99-usb-auto-organize.rules \
        /etc/udev/rules.d/99-usb-auto-organize.rules.disabled
Reload rules after disabling:

bash
Copy code
sudo udevadm control --reload-rules
Limitations
Linux-only (requires udev)

Requires auto-mount enabled

Executes once per USB insertion

Does not detect file changes after insertion

Future Enhancements
Whitelist trusted USB devices


Per-device configuration

Notification alerts

systemd integration

Read-only scan mode


Conclusion
USB auto-detection demonstrates:

Kernel-level event handling

Linux system automation

Safe Bash scripting

Real-world operational design

This is professional-grade Linux automation, not a toy script.
