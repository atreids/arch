#!/bin/bash -e

echo "Copying bin files"
mkdir -pv $HOME/.local/bin
cp -rb ../bin/* $HOME/.local/bin/
echo "Successfully copied bin files"
