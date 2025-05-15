# Post Install Notes for Arch Linux

## User creation

Create personal user

- Create: `useradd -m -G wheel -s /bin/bash aaron`
- Set password: `passwd aaron`
- Uncomment line in sudoers file that allows users of `wheel` group to use sudo - Edit file with `visudo` command

Log in as user and perform rest of setup as that user.

## Update system and config pacman

- `sudo pacman -Syu`

Uncomment `Color` and `ParallelDownloads` lines in `/etc/pacman.conf`

Ensure keyring is initialised properly:

- `sudo pacman-key --init`
- `sudo pacman-key --populate archlinux`

## Sound

Install PipeWire for an easy audio life

- `sudo pacman -S pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack`

- `sudo systemctl --user --now enable wireplumber`

## Printing

- Install print system - `sudo pacman -S cups cups-pdf`
- Start service - `sudo systemctl enable cups.service && sudo systemctl start cups.service`
- Install local network discovery for printers with Avahi - `sudo pacman -S nss-mdns` && `sudo systemctl enable avahi-daemon.service`
- Then edit `/etc/nsswitch.conf` to contain `hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns`

## Firewall

Install and config basic Uncomplicated Firewall

- Install `sudo pacman -S ufw`
- Start/Enable `ufw.service`

Run basic config commands

``` bash
ufw default deny
ufw allow from 192.168.0.0/24
ufw allow Deluge
ufw limit ssh
ufw enable
```

## Network

NetworkManager was installed and enabled during installation.
But to connect to wifi:

- List `nmcli device wifi list`
- Connect `nmcli device wifi connect <SSID_OR_BSSID> password <password>`

## Install generally useful packages

- `sudo pacman -S --needed base-devel git`

``` bash
sudo pacman -S bat lsd neofetch openssh zsh pv fzf clang llvm rust lm_sensors python-pip psutils htop bashtop imagemagick jq github-cli lolcat ripgrep inetutils net-tools 
```

## Yay

Install yay to access AUR

- `git clone https://aur.archlinux.org/yay.git`
- `cd yay`
- `makepkg -si`
- `yay --version`
- `rm -rf ~/yay`

## Generate SSH key

- `ssh-keygen`
