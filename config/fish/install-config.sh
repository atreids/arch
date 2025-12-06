#!/bin/bash -e

script_path=$0
script_dir=$(dirname "$script_path")

cd "$script_dir" || {
	echo "Error: failed to change directory to $script_dir" >&2
	exit 1
}

app_name=fish

echo "Installing $app_name config..."

config_dir_path=$HOME/.config/fish

install() {
	# Copy. Backup existing files.
	cp -rb ./config/* $config_dir_path/ --suffix .backup
	echo "Installed $app_name successfully."
}

makeConfigDir() {
	mkdir -pv $config_dir_path
}

makeConfigDir
install

