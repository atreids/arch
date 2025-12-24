#!/bin/bash -e
# Install Arch Linux on Laptop

disk=/dev/nvme0n1

loadkeys uk
timedatectl set-ntp true
wipefs -af $disk
sgdisk --zap-all $disk
sgdisk -n 1:0:+550M -c efi -t ef00 $disk
sgdisk -n 2:0:+4G -c swap -t 8200 $disk
sgdisk -n 3:0:0 -c root -t 8300 $disk
