#!/bin/bash -e

script_path=$0
script_dir=$(dirname "$script_path")

cd "$script_dir" || {
  echo "Error: failed to change directory to $script_dir" >&2
  exit 1
}

#Iterate through all items in this directory. If item is a directory, run "install-config.sh" script in that directory.
echo "Starting..."
for item in */; do
  if [ -d "$item" ]; then
    ./$item/install-config.sh
  fi
done
echo "Successfully installed all user config files."
