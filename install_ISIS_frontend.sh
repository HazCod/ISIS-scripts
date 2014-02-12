#!/bin/bash

url="https://github.com/HazCod/ISIS-frontend.git"
dir=".isis"


function installPackage() {
	sudo apt-get -q -y install $1
	exit
}

function installDependencies {
	export DEBIAN_FRONTEND=noninteractive
	
	installPackage git
	installPackage python
	isntallPackage python-mysqldb
	installPackage libssl-dev
}

function getFromGit {
	git clone $url $dir
}

function checkDefArgs() {
	if ![ valid_ip $1 ]; then
		echo "Please provide a valid IP."
		exit 1
	fi
	def_ip=$1
	shift
	
	if ![ valid_ip $2 ]; then
		echo "Please provide a valid gateway IP.";
		exit 1
	fi
	def_gateway=$2
	shift

	if ![ $3 ~= ^[0-255]{4}$]; then
		echo "Please provide a valid netmask."
		exit 1
	fi
	def_netmask=$3
	shift

	if ![ valid_ip $4 ]; then
		echo "Please provide a valid dns IP.";
		exit 1
	fi
	def_dns=$4
	shift
}

function checkArgs() {
	if ![ valid_ip $1 ]; then
		echo "Please provide a valid IP."
		exit 1
	fi
	ip=$1
	
	if ![ valid_ip $2 ]; then
		echo "Please provide a valid gateway IP.";
		exit 1
	fi
	gateway=$2

	if ![ $3 ~= ^[0-255]{4}$]; then
		echo "Please provide a valid netmask."
		exit 1
	fi
	netmask=$3

	if ![ valid_ip $4 ]; then
		echo "Please provide a valid dns IP.";
		exit 1
	fi
	dns=$4
}

function writeDefaultsIP() {
	cd /etc/network/
	echo "auto eth0" >> $1
	echo "iface eth0 inet static" >> $1
	echo "address $def_ip" >> $1
	echo "netmask $def_netmask" >> $1
	echo "gateway $def_gateway" >> $1
	echo "dns-nameservers $def_dns" >> $1
}

function writeIP() {
	cd /etc/network
	echo "auto eth0" >> $1
	echo "iface eth0 inet static" >> $1
	echo "address $ip" >> $1
	echo "netmask $netmask" >> $1
	echo "gateway $gateway" >> $1
	echo "dns-nameservers $dns" >> $1
}

function installIP {
	sudo -s
	cd /etc/network/
	mv interfaces interfaces.old
	echo "auto lo\niface lo inet loopback" >> interfaces
	if [[ -z $def_ip ]]; then
		writeDefaultsIP "interfaces.def"
	fi
	if [[ -z $ip ]]; then
		writeIP "interfaces"
	exit
}

function usage {
	echo "install_ISIS_frontend.sh";
	echo "----------------------------";
	echo "Usage: install_ISIS_frontend.sh [-d ip_address ip_gateway ip_netmask ip_dns] [ip_address ip_gateway ip_netmask ip_dns]";
	echo "";
	echo "Options:";
	echo "-d	default		If DHCP or given IP settings don't work, it falls back to the following IP settings.";
}

# SCRIPT BEGIN

if [ "$(id -u)" != "0" ]; then
	echo "Please run this script as root."
	exit 1
fi

# if there are any arguments
if [ $# > 0 ]; then 
	# if we are giving a default value
	if [ $1 = "-d" ]; then
		# we must have at least 5 values (-d, ip, gateway, netmask, dns) OR 9 values.
		if ![ $# = 5 ] && ![ $# = 9 ]; then
			usage
			exit 1
		
		fi
		# 5 arguments, so dhcp with fallback defaults
		if [ $# = 5]; then
			shift			
			checkDefArgs $1 $2 $3 $4
		else
		# 9 arguments, so given value with fallback defaults.
			shift			
			checkDefArgs $1 $2 $3 $4
			checkArgs $1 $2 $3 $4
		fi	
	# else we need 4 values (ip, gateway, netmask, dns)
	elif [ $# = 4 ]; then
		checkArgs $1 $2 $3 $4
	else
		usage
		exit 1
	fi
fi

function installHostname(){
	sudo -s
	echo $1 > "/etc/hostname"
	/etc/init.d/hostname.sh start
	exit
}

read -p "What hostname/ID should be given to this unit? This must be unique!" host
installDependencies
cd ~
getFromGit
installIP
installHostname $host

# SCRIPT END


function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}
