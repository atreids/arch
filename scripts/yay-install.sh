#!/bin/bash -e

if [ $(id -u) -eq 0 ]; then
  echo Do not run this as root.
  exit
fi

# Yay
pacman -S --noconfirm base-devel git
git clone https://aur.archlinux.org/yay.git
cd ./yay
makepkg -si
cd ../
rm -rf ./yay/
