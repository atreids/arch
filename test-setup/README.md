# Testing fresh Arch installs

It's a good idea to check that the setup steps are correct on a _working_ system first before performing a complete fresh install.

Here are some helper scripts to start a QEMU x86_64 virtual machine with the Arch ISO mounted to simulate a fresh setup.

## Preqs

- QEMU
- Arch ISO file

## Usage

`./start-arch-vm.sh <path-to-arch-iso>` - Start VM and pass in path to ISO file.
