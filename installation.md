# Arch Setup

Installation docs of Arch linux

## Installation

Follow installation docs on [wiki](https://wiki.archlinux.org/title/Installation_guide#):

- Acquire image
- Verify image signature
- Load image onto USB
- Boot USB
- Set keyboard layout and font - `loadkeys uk`
- Connect internet (ethernet works automatically)
- Check that `cat /sys/firmware/efi/fw_platform_size` returns `64`
- Sync clock - `timedatectl`
- Partition disks

N.B Partitioning the disks:
I would use the example layout of:

- - `/boot` 1GB - EFI System Partition - To install GRUB inside
- - `/swap` 4GB - Swap Partition
- - `/` Root

Helpful commands: `fdisk -l` `fdisk /dev/disk`

- Format partitions (N.B EFI System part is fat32)
- Mount partitions
- Start installing packages into mounted filesystems (this is similar to Linux from scratch)
- - Install `pacstrap -K /mnt base linux and linux-firmware` packages. "linux" is the linux kernel, base contains super minimal packages, including bash, pacman, coreutils and more.
- Generate fstab file.
- Chroot into /mnt
- Install additional necessary packages (ucode packages, nvim, man/info pages)
- Set timezone/clock info
- - Timezone: Europe/London
- - When setup, ensure future NTP sync by running `timedatectl set-ntp true`
- Set localization
- - Edit /etc/locale.gen to uncomment `en_US.UTF-8 UTF-8` and `en_GB.UTF-8 UTF-8`
- - Run `locale-gen`
- - Set `LANG=en_GB.UTF-8` in `/etc/locale.conf`
- - Set keyboard layout for console: `loadkeys uk` and set `KEYMAP=uk` in `/etc/vconsole.conf`
- Create hostname file
- Set root password - `passwd`
- Install GRUB in `/boot`
- - Install packages - `pacman -S grub efibootmgr`
- - Install grub in EFI mount partition - `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB`
- - Generate Grub config - `grub-mkconfig -o /boot/grub/grub.cfg`
- Exit chroot and reboot (`exit` then `reboot`)
- Remove USB

Move on to post install document.

### Packages I installed during initial setup on Thinkpad T480s

``` bash
pacman -S intel-ucode networkmanager e2fsprogs dosfstools bluez man-db texinfo man-pages vi vim neovim sudo
````
