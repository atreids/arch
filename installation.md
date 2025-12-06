# Arch Setup

Installation notes for Arch Linux.

> What is Arch Linux?

Arch Linux is an independent (aka, not based on another Distro), x86_64, Linux distribution. It provides a bare-bones installation, only providing a [small base package](https://archlinux.org/packages/core/any/base/) (including a [package manager](https://wiki.archlinux.org/title/Pacman), systemd, and some other core utility programs), and the [Linux kernel](https://archlinux.org/packages/core/any/base/).

## Installation

Follow the installation docs on the [wiki](https://wiki.archlinux.org/title/Installation_guide#), but the general steps are as follows:

- Acquire the ISO image.
- Verify image signature.
- [Load image onto USB](https://wiki.archlinux.org/title/USB_flash_installation_medium).
- If necessary, disable secure boot.
- Boot from the USB. You are now in a live installation environment. From here, you must setup a hard-drive by partitioning and formatting it, and then installing the base package and Linux kernel into the file system.

### Live Environment

Some configuration of the live environment may be necessary in order to proceed with the installation. Primarily connecting to the internet and ensuring keyboard layout is compatible.

- Set keyboard layout - `loadkeys uk`
- Connect to the internet. Ethernet will work automatically. If you need to setup a WiFi connection, refer to the Wiki.
- Check that `cat /sys/firmware/efi/fw_platform_size` returns `64`.
- Sync system clock - `timedatectl`

### Setting up the hard drive

Partition (using `fdisk`) the hard-drive you will be installing Arch on.

N.B Partitioning the disks:
I would use the example layout of:

- - `/boot` 1GB - EFI system partition - To install GRUB inside
- - `/swap` 4GB - Linux swap
- - `/` Root - Linux x86_64 root

Format the partitions

- `mkfs.ext4 /dev/root_partition`
- `mkswap /dev/swap_partition`
- `mkfs.fat -F 32 /dev/efi_system_partition` - ONLY DO THIS IF THERE IS YOU CREATED THE EFI PART ABOVE. IF YOU DO THIS TO AN EXISTING EFI PART YOU WILL REMOVE BOOTLOADERS FROM ANOTHER OS.

### Installing Arch

Now that you've setup the hard-drive, you can mount it and install the basic Arch installation on it.

- Mount partitions
- - `mount /dev/root_partition /mnt`
- - `mount --mkdir /dev/efi_system_partition /mnt/boot`
- - `swapon /dev/swap_partition`

Install Arch base system:

- `pacstrap -K /mnt base linux linux-firmware`
- - N.B: Depending on first boot environment of the machine you are installing Arch onto, you may wish to install additional packages via `pacstrap` before continuing. Especially if the machine will require a WiFi connection.
- - Basic recommended additional packages: `<AMDorINTEL>-ucode networkmanager bluez man-db man-pages texinfo vi vim sudo e2fsprogs dosfstools`. This basic set of additional packages will ensure you will be able to setup WiFi and Bluetooth connections, have basic text editors for modifying config files, manage disk, and access man pages for instructions. 

- Generate an fstab file.
- - `genfstab -U /mnt >> /mnt/etc/fstab`
- Chroot into the new system.
- - `arch-chroot /mnt`

In new system:

- Set timezone/clock info
- - Timezone: Europe/London - so probably `ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime` if you are in UK.
- - When setup, ensure future NTP sync by running `timedatectl set-ntp true`
- Set localization
- - Edit /etc/locale.gen to uncomment `en_US.UTF-8 UTF-8` and `en_GB.UTF-8 UTF-8`
- - Run `locale-gen`
- - Set `LANG=en_GB.UTF-8` in `/etc/locale.conf`
- - Set keyboard layout for console: `loadkeys uk` and set `KEYMAP=uk` in `/etc/vconsole.conf`
- Create hostname file and add a hostname for the system.
- - `echo <hostname> > /etc/hostname`
- Set root password - `passwd`

### Installing a bootloader

We now need to install a bootloader (probably GRUB) inside `/boot` partition.

- Install packages - `pacman -S grub efibootmgr`
- Install grub in EFI mount partition - `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB`
- Generate Grub config - `grub-mkconfig -o /boot/grub/grub.cfg`
- - N.B By default the GRUB will not probe for additional operating systems aside our newly installed Arch system. If you want to dual-boot, refer to the Arch wiki's GRUB page.
- Exit chroot and reboot (`exit` then `reboot`)
- Remove USB

Move on to post install document.

