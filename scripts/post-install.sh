#!/bin/bash -e

if [ $(id -u) -eq 0 ]; then
  echo "Run this script as your normal user. Not with sudo or root."
  exit 1
fi

#
# [ Basic Tools ]
#
pacman -S --noconfirm tmux openssh psutils htops inetutils net-tools tree wget curl ncdu nmap nmon iftop iperf3 ripgrep base-devel git jq imagemagick btop bat gnome-keyring

./paru-install.sh

#
# [ Terminals ]
# NOTE: Having multiple available is useful as some programs expect certain default terminals to exist.
#
pacman -S --noconfirm alacritty kitty ghostty foot


#
# [ Niri Desktop ]
#
pacman -S --noconfirm niri fuzzel mako waybar xwayland-satellite swayidle swaylock xdg-desktop-portal-gtk xdg-desktop-portal-gnome

#
# [ Configs ]
#
../config/install-configs.sh
./init-bin.sh

