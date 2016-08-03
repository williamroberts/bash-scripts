#!/usr/bin/env bash

# Basic requirements
TO_INSTALL_BASIC=(apt-transport-https software-properties-common wget vim curl unzip);

echo "LOGGING: Installing basic tools (${TO_INSTALL_BASIC[@]})...";
apt-get update && apt-get install -y "${TO_INSTALL_BASIC[@]}";
echo "LOGGING: Installing basic tools (${TO_INSTALL_BASIC[@]})... complete";

# Add Google PPA
echo "LOGGING: Adding Google PPA...";
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && chmod 644 /etc/apt/sources.list.d/google-chrome.list;
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -;
echo "LOGGING: Adding Google PPA... complete";

# Add Java PPA
echo "LOGGING: Adding Webupd8team Java ppa...";
add-apt-repository -y ppa:webupd8team/java;
echo "LOGGING: Adding Webupd8team Java ppa... complete";

# Add Docker PPA
echo "LOGGING: Adding Docker ppa...";
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && chmod 644 /etc/apt/sources.list.d/docker.list;
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D;
echo "LOGGING: Adding Docker ppa... complete";

# Add Atom PPA
echo "LOGGING: Adding Webupd8team Atom ppa...";
add-apt-repository -y ppa:webupd8team/atom;
echo "LOGGING: Adding Webupd8team Atom ppa... complete";

# Add Spotify PPA
echo "LOGGING: Adding Spotify ppa...";
echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list && chmod 644 /etc/apt/sources.list.d/spotify.list;
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886;
echo "LOGGING: Adding Spotify ppa... complete";

# More advanced requirements
TO_INSTALL=(cowsay fortune git terminator vlc python3 maven apache2 google-chrome-stable oracle-java8-installer docker atom spotify-client shellcheck);

# Automatically accept the Oracle Java License Agreement
echo "LOGGING: Adding Oracle license acceptance to debconf...";
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections;
echo "LOGGING: Adding Oracle license acceptance to debconf... complete";

echo "LOGGING: Installing tools (${TO_INSTALL[@]})...";
apt-get update && \
	apt-get install -y "${TO_INSTALL[@]}";
echo "LOGGING: Installing tools (${TO_INSTALL[@]})... complete";

# Manually download and install AWS CLI (apt repository can be out of date, so this is the recommended way)
echo "LOGGING: Installing AWS CLI manually by downloading bundle...";
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
	unzip awscli-bundle.zip && \
	./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws;
echo "LOGGING: Installing AWS CLI manually by downloading bundle... complete";

# Move all scripts into scripts folder in home directory
echo "LOGGING: Creating ~/scripts and importing scripts...";
mkdir ~/scripts && \
	cp /scripts/* ~/scripts/. && \
	rm ~/scripts/install.sh;
echo "LOGGING: Creating ~/scripts and importing scripts... complete";

# Initial setup of .bashrc
echo "LOGGING: Updating ~/.bashrc...";
echo bashrc >> ~/.bashrc;
echo >> ~/.bashrc;
echo "LOGGING: Updating ~/.bashrc... complete";

# Source all scripts
echo "LOGGING: Writing source script statements to ~/.bashrc...";
for i in $( ls . );
do
	echo "source ~/scripts/$i" >> ~/.bashrc;
	printf "LOGGING: Added to .bashrc: %s\n" $i;
done;
echo "LOGGING: Writing source script statements to ~/.bashrc... complete";

# Echo a blank line just to space things out a bit.
echo >> ~/.bashrc;

# Finally add a call to welcome() so it gets executed every time we login i.e. when .bashrc is sourced
echo "LOGGING: Adding welcome() call to the end of ~/.bashrc...";
echo "welcome;" >> ~/.bashrc;
echo "LOGGING: Adding welcome() call to the end of ~/.bashrc... complete";

# Finally source the new .bashrc file we've created
echo "LOGGING: Sourcing completed ~/.bashrc...";
source ~/.bashrc;
echo "LOGGING: Sourcing completed ~/.bashrc... complete";

echo "";
echo "Workspace setup complete. Enjoy!";
