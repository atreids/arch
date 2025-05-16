#!/bin/bash -e
# Minimal setup script for Arch linux.

# Check we have root access
if [ $(id -u) -ne 0 ]; then
  echo This script requires root. Please sudo.
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
pacman -S fail2ban
systemctl --now enable fail2ban.service

# Tools
pacman -S --noconfirm tmux openssh psutils htop inetutils net-tools tree wget curl ncdu nmap nmon iftop iperf3 bash-completion ripgrep
