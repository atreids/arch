#!/bin/bash -e

if [ -z "$1" ]; then
	echo "Pass path to Arch ISO file as a parameter to this command. Exiting."
	exit
fi

echo "Creating fresh VM with Arch ISO attached..."
echo "Creating hard disk image..."
if [ -f ./disk.img ]; then
	echo "Existing disk found. Removing"
	rm ./disk.img
fi
qemu-img create -f qcow2 disk.img 20G
echo "Disk created. Starting VM"

qemu-system-x86_64 \
	-m 8G \
	-cpu qemu64 \
	-smp 4 \
	-hda disk.img \
	-usb \
	-device usb-storage,drive=usbstick \
	-drive id=usbstick,if=none,media=cdrom,file=$1

