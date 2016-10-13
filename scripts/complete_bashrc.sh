#!/usr/bin/env bash

# Add a call to welcome() so it gets executed every time we login i.e. when .bashrc is sourced
echo "LOGGING: Adding welcome() call to the end of $HOME/.bashrc...";
echo "welcome;" >> "$HOME/.bashrc";
echo "LOGGING: Adding welcome() call to the end of $HOME/.bashrc... complete";

# Finally source the new .bashrc file we've created
echo "LOGGING: Sourcing completed $HOME/.bashrc...";
source "$HOME/.bashrc";
echo "LOGGING: Sourcing completed $HOME/.bashrc... complete";

echo "";
echo "Workspace setup complete. Enjoy!";
