#!/usr/bin/env bash

# Basic requirements
TO_INSTALL_BASIC=(apt-transport-https software-properties-common wget vim curl)

apt-get update && apt-get install -y "${TO_INSTALL_BASIC[@]}"

# Add Google PPA
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && chmod 644 /etc/apt/sources.list.d/google-chrome.list
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# Add Java PPA
add-apt-repository ppa:webupd8team/java

# Add Docker PPA
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && chmod 644 /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Add Atom PPA
add-apt-repository ppa:webupd8team/atom

# Add Spotify PPA
echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list && chmod 644 /etc/apt/sources.list.d/spotify.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886

# More advanced requirements
TO_INSTALL=(cowsay fortune git terminator vlc python3 maven awscli apache2 google-chrome-stable oracle-java8-installer docker atom spotify-client shellcheck);

apt-get update && \
	echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
	apt-get install -y "${TO_INSTALL[@]}";

# Move all scripts into scripts folder in home directory
mkdir ~/scripts
cp /scripts/* ~/scripts/.
rm ~/scripts/install.sh

# Initial setup of .bashrc
echo bashrc >> ~/.bashrc;
echo >> ~/.bashrc;

# Source all scripts
for i in $( ls . );
do
	echo "source ~/scripts/$i" >> ~/.bashrc;
	printf "Added to .bashrc: %s\n" $i;
done;

# Echo a blank line just to space things out a bit.
echo >> ~/.bashrc;

# Finally add a call to welcome() so it gets executed every time we login i.e. when .bashrc is sourced
echo "welcome;" >> ~/.bashrc;

# Finally source the new .bashrc file we've created
source ~/.bashrc;
