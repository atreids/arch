#!/bin/bash -e
# Install Arch Linux on Laptop

disk=/dev/nvme0n1
espPart="${disk}p1"
swapPart="${disk}p2"
luksPart="${disk}p3"

loadkeys uk
timedatectl set-ntp true
wipefs -af $disk
sgdisk --zap-all $disk
partprobe $disk
sgdisk -n 0:0:+550M -c 0:esp -t 0:ef00 $disk
sgdisk -n 0:0:+4G -c 0:swap -t 0:8200 $disk
sgdisk -n 0:0:0 -c 0:luksroot -t 0:8309 $disk
partprobe $disk
cryptsetup luksFormat --type luks2 $luksPart
cryptsetup open $luksPart root #Will unencrypt partition and place in /dev/mapper/root
mkfs.vfat -F32 -n ESP $espPart
mkfs.btrfs -f -L root -v /dev/mapper/root
mount /dev/mapper/root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@root
btrfs subvolume list /mnt
umount /mnt

mount -t btrfs -o subvol=@,compress=zstd:1 -m /dev/mapper/root /mnt
mount -t btrfs -o subvol=@home,compress=zstd:1 -m /dev/mapper/root /mnt/home
mount -t btrfs -o subvol=@cache,compress=zstd:1 -m /dev/mapper/root /mnt/var/cache
mount -t btrfs -o subvol=@log,compress=zstd:1 -m /dev/mapper/root /mnt/var/log
mount -t btrfs -o subvol=@root,compress=zstd:1 -m /dev/mapper/root /mnt/root
mount -m $espPart /mnt/efi

reflector --country GB --age 24 --sort rate --save /etc/pacman.d/mirrorlist

