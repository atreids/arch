#!/bin/bash -e
# Minimal setup script for Arch linux.

# Check we have root access
if [ $(id -u) -ne 0 ]; then
  echo "This script must be run as root."
  exit
fi

# Update whole system
pacman -Syu --noconfirm
pacman-key --init
pacman-key --populate archlinux

# UFW
pacman -S ufw --noconfirm
ufw default deny
ufw enable
systemctl --now enable ufw.service

# Fail2ban
pacman -S --noconfirm fail2ban
systemctl --now enable fail2ban.service

