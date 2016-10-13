#!/usr/bin/env bash

echo "LOGGING: Starting install_aliases.sh script..."

ALIASES_PATH="/scripts/aliases"

# Move all scripts into scripts folder in home directory
echo "LOGGING: Creating $HOME$ALIASES_PATH and importing...";
mkdir -p "$HOME$ALIASES_PATH" && \
	cp -r "$ALIASES_PATH/." "$HOME$ALIASES_PATH/.";
echo "LOGGING: Creating $HOME$ALIASES_PATH and importing... complete";

# Source all scripts
echo "LOGGING: Writing source script statements to $HOME/.bashrc...";
for i in "$HOME$ALIASES_PATH"/*;
do
	echo "source $i;" >> "$HOME/.bashrc";
	printf "LOGGING: Added to .bashrc: %s\n" "$i";
done;
echo "LOGGING: Writing source script statements to $HOME/.bashrc... complete";

# Echo a blank line just to space things out a bit.
echo >> "$HOME/.bashrc";

echo "LOGGING: install_aliases.sh script complete"
