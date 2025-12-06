!#/bin/bash -e

if [ $(id -u) -eq 0 ]; then
  echo "Do not run this as root."
  exit 1
fi

sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/paru.git
cd ./paru
makepkg -si
cd ../
rm -rf ./paru

