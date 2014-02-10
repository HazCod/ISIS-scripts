#!/bin/bash

url="https://github.com/HazCod/ISIS-frontend.git"
dir=".isis"


function installPackage {
	sudo apt-get -q -y install $1
	sudo -k
}

function installDependencies {
	export DEBIAN_FRONTEND=noninteractive
	
	installPackage git
	installPackage python
}

function getFromGit {
	git clone $url $dir
}


# SCRIPT BEGIN

if [ "$(id -u)" != "0" ]; then
	echo "Please run this script as root."
	exit 1
fi

installDependencies
cd ~
getFromGit

# SCRIPT END
