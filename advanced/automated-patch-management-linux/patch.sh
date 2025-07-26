#!/bin/bash

# -------------------------------
# Automated Linux Patch Script
# Author: Atikul | iamatikahad
# Usage: sudo ./patch.sh
# -------------------------------

LOGFILE="/var/log/patch-management.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "❌ This script must be run as root"
  exit 1
fi

# Detect OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
else
  echo "❌ Cannot detect operating system."
  exit 1
fi

echo "[$DATE] Starting patch process on $OS..." | tee -a "$LOGFILE"

# Patch based on OS
case "$OS" in
  ubuntu|debian)
    apt update && apt upgrade -y >> "$LOGFILE" 2>&1
    ;;
  centos|rhel|fedora)
    yum update -y >> "$LOGFILE" 2>&1
    ;;
  rocky|almalinux)
    dnf update -y >> "$LOGFILE" 2>&1
    ;;
  *)
    echo "❌ Unsupported OS: $OS" | tee -a "$LOGFILE"
    exit 1
    ;;
esac

echo "[$DATE] ✅ Patch process completed." | tee -a "$LOGFILE"
