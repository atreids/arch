#!/bin/bash -e

if [ $(id -u) -eq 0 ]; then
  echo "Run this script as your normal user. Not with sudo or root."
  exit 1
fi

#
# [ Basic Tools ]
#
echo "Installing basic tools"
sudo pacman -S --needed - < ./basic_tools.txt

./paru-install.sh

chsh -s /usr/bin/fish aaron

#
# [ Terminals ]
# NOTE: Having multiple available is useful as some programs expect certain default terminals to exist.
#
echo "Installing terminals"
sudo pacman -S --needed - < ./terminals.txt


#
# [ Niri Desktop ]
#
echo "Installing Niri desktop environment"
sudo pacman -S --needed - < ./niri_list.txt
systemctl --user enable waybar.service
systemctl --user enable swayidle.service

#
# [ Configs ]
#
echo "Setting up configuration files"
../config/install-configs.sh
echo "Copying binaries"
./init-bin.sh

