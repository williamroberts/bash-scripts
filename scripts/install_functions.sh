#!/usr/bin/env bash

echo "LOGGING: Starting install_functions.sh script..."

FUNCTIONS_PATH="/scripts/functions"

# Move all scripts into scripts folder in home directory
echo "LOGGING: Creating $HOME$FUNCTIONS_PATH and importing...";
mkdir -p "$HOME$FUNCTIONS_PATH" && \
	cp -r "$FUNCTIONS_PATH/." "$HOME$FUNCTIONS_PATH/.";
echo "LOGGING: Creating $HOME$FUNCTIONS_PATH and importing... complete";

# Source all scripts
echo "LOGGING: Writing source script statements to $HOME/.bashrc...";
for i in "$HOME$FUNCTIONS_PATH"/*;
do
	echo "source $i;" >> "$HOME/.bashrc";
	printf "LOGGING: Added to .bashrc: %s\n" "$i";
done;
echo "LOGGING: Writing source script statements to $HOME/.bashrc... complete";

# Echo a blank line just to space things out a bit.
echo >> "$HOME/.bashrc";

echo "LOGGING: install_functions.sh script complete"
