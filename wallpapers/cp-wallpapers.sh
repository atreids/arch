#!/bin/bash -e
echo "Creating wallpaper directory and copying them..."
mkdir -pv $HOME/Pictures/Wallpapers/
cp -rb ./img/* $HOME/Pictures/Wallpapers/
echo "Copied wallpapers."
