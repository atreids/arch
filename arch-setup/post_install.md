# Post Install Notes for Arch Linux

Once you have completed the steps in the [installation](./installation.md) doc these steps should be followed on the first boot into your new Arch system. They provide some important security steps, quality of life improvements, and general setup. 

This doc is split into two sections:

1. Universal - should always be carried out.
2. Desktop - additional QoL steps that you may want to perform on a personal computer.

## Universal

### User creation

Create a separate user from `root`. The name can be anything.

- Create: `useradd -m -G wheel -s /bin/bash <username>`
- Set password: `passwd <username>`
- Ensure that the line in sudoers file that allows users of `wheel` group to use sudo is uncommented.
- - You can edit file with `visudo` command

You should now log in (type `exit` to log out of `root`) as this user and use it to perform the rest of the setup. Using `sudo` as necessary for privileged commands. Logging in as `root` should be avoided in the majority of circumstances.

### Update system and configure pacman


- Uncomment `Color` and `ParallelDownloads` lines in `/etc/pacman.conf`
- Update whole system: `sudo pacman -Syu`

Ensure keyring is initialised properly:

- `sudo pacman-key --init`
- `sudo pacman-key --populate archlinux`

### Firewall

Install and configure a basic firewall.

- Install `sudo pacman -S ufw`

Configure basic firewall.

N.B If on a remote server, you may wish to enable SSH before enabling the firewall `ufw allow ssh`.

``` bash
ufw default deny
ufw enable
```

Ensure ufw starts on system reboot:

- Enable/Start `ufw.service`
- - `sudo systemctl enable ufw.service`.
- - `sudo systemctl start --now ufw.service`.


### Network

You may have installed and configured NetworkManager in the installation step. If not, we should do that now.

- `sudo pacman -S networkmanager`
- `sudo systemctl enable NetworkManager.service`

To setup WiFi connection:

- List `nmcli device wifi list`
- Connect `nmcli device wifi connect <SSID_OR_BSSID> --ask`

### Universal packages

Install universally useful packages (unless system has very limited storage capacity).

- `sudo pacman -S tmux openssh psutils htop inetutils net-tools tree wget curl ncdu nmap nmon iftop iperf3 bash-completion ripgrep`

### Yay

Depending on what you are using the system for, you may or may not need yay. Yay makes installing packages from the Arch User Repository easy.

- `sudo pacman -S base-devel git`
- `git clone https://aur.archlinux.org/yay.git`
- `cd yay`
- `makepkg -si`
- `yay --version`
- `rm -rf <yay-git-dir>`

## Desktop

These further steps help configure a system that will be used more as a personal computer, rather than a bare-bones server or headless machine.

### Install more generally useful (and fun) packages


``` bash
sudo pacman -S bat lsd neofetch zsh pv fzf clang llvm rust lm_sensors python-pip imagemagick jq github-cli lolcat neovim nvm 
```



### Sound

Install PipeWire for an easy audio life

- `sudo pacman -S pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack`

- `systemctl --user --now enable wireplumber`

### Printing

- Install print system - `sudo pacman -S cups cups-pdf`
- Start service - `sudo systemctl enable cups.service && sudo systemctl start cups.service`
- Install local network discovery for printers with Avahi - `sudo pacman -S nss-mdns` && `sudo systemctl enable avahi-daemon.service`
- Then edit `/etc/nsswitch.conf` to contain `hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns`

---

#### Generating SSH key

- `ssh-keygen`
