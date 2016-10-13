#!/usr/bin/env bash

echo "LOGGING: Starting init_bashrc.sh script..."

# Initial setup of .bashrc
echo "LOGGING: Intialising $HOME/.bashrc...";
cat bashrc >> "$HOME/.bashrc";
echo "LOGGING: Intialising $HOME/.bashrc... complete";

echo "LOGGING: init_bashrc.sh script complete"
