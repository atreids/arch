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
systemctl --user add-wants niri.service mako.service
systemctl --user add-wants niri.service waybar.service
systemctl --user add-wants niri.service swaybg.service
systemctl --user add-wants niri.service swayidle.service

#
# [ Configs ]
#
echo "Setting up configuration files"
../config/install-configs.sh
echo "Copying wallpapers"
../wallpapers/cp-wallpapers.sh
echo "Copying binaries"
./init-bin.sh
echo "Done."
