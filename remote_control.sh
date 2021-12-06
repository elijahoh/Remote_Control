#!/bin/bash
#Author: Elijah Oh
#Date Created: 08/10/2021
#This is a script that communicates with a remote server and executes tasks anonymously.
#Date Modified: 09/10/2021

#Note: Amazon EC2 server was used for this script
#      Please update KEYGEN_CREATE function.				#create the SSH key file
#
#      Please update the following SSH_SETUP function's variables:
#	       - $AWS_USER						#username to log into server
#	       - $PUBLIC_DNS						#server's public address
#	       - $KEYGEN_FILE						#keygen filename
#	       - $KEYGEN_MD5						#md5 hash of keygen

#setting up of ssh keygen and connect to aws server
function SSH_SETUP {
	#updatedb, locate .ssh directory and assign variable
	sudo updatedb; PATH_SSH=$(sudo locate .ssh | egrep "\.ssh$" | egrep "^/home")
	AWS_USER="username" #username to log into server
	PUBLIC_DNS="ec2-<IP Address>.compute-1.amazonaws.com" #server's public address
	KEYGEN_FILE="keygen.pem" #keygen filename
	KEYGEN_MD5="3b63be649b3e7820c932be009ed013f3" #md5 hash of keygen
	#updatedb, locate keygen file in .shh directory and assign variable
	sudo updatedb; KEYGEN_FPATH=$(locate $KEYGEN_FILE | grep -E "\.ssh")
	#change directory to home
	cd ~
	#check if file keygen file does not exists
	if  [ ! -f "$KEYGEN_FPATH" ]; then
		#check if .ssh directory exists
		if [ -d "$PATH_SSH" ]; then
			#create keygen file
			KEYGEN_CREATE
			#updatedb, locate newly created keygen file and update KEYGEN_FPATH
			sudo updatedb; KEYGEN_FPATH=$(locate $KEYGEN_FILE | head -n 1)
			#change keygen file permission 
			sudo chmod 400 $KEYGEN_FILE
			#move keygen file to .ssh
			mv $KEYGEN_FPATH $PATH_SSH
			#updatedb, locate and update $KEYGEN_FPATH in .shh directory
			sudo updatedb; KEYGEN_FPATH=$(locate $KEYGEN_FILE | grep -E "\.ssh")
			echo -e "\n\e[1;35m[*]\e[0m SSH key created: $KEYGEN_FPATH"
		else 
			#create .ssh directory if it does not exits
			mkdir .ssh
			#updatedb, locate newly creeated .ssh directory and update $PATH_SSH
			sudo updatedb; PATH_SSH=$(sudo locate .ssh | egrep "\.ssh$" | egrep "^/home")
			#change permission
			sudo chmod 700 .ssh
			#create keygen file
			KEYGEN_CREATE
			#change kegen file permission 
			sudo chmod 400 $KEYGEN_FILE
			#move keygen file to .ssh
			if [ -d "$PATH_SSH" ]; then
				#updatedb, locate newly created keygen file and update $KEYGEN_FPATH
				sudo updatedb; KEYGEN_FPATH=$(locate $KEYGEN_FILE | head -n 1)
				mv $KEYGEN_FPATH $PATH_SSH
				#updatedb, locate and update $KEYGEN_FPATH in .shh directory
				sudo updatedb; KEYGEN_FPATH=$(locate $KEYGEN_FILE | grep -E "\.ssh")
				echo -e "\n\e[1;35m[*]\e[0m SSH key created: $KEYGEN_FPATH"
			fi
		fi 
	fi
	#updatedb, locate and update $KEYGEN_FPATH in .shh directory
	sudo updatedb; KEYGEN_FPATH=$(locate $KEYGEN_FILE | grep -E "\.ssh")
	#if keygen file exists in .ssh directory 
	if [ -f "$KEYGEN_FPATH" ]; then
		#assign md5sum hash of $KEYGEN_FHASH to a varriable
		KEYGEN_FHASH=$(md5sum $KEYGEN_FPATH | awk '{print $1}')
		if [ "$KEYGEN_FHASH" == "$KEYGEN_MD5" ];then
			echo -e "\n\e[1;37m[*]\e[0m Ready to connect to remote server"
			echo -e "\e[1;36m[*]\e[0m $KEYGEN_FPATH: SSH Key Found"
			echo -e "\e[1;36m[*]\e[0m $KEYGEN_FPATH MD5 hash: Matched"
		else
			echo -e "\n\e[1;31m[!]\e[0m $KEYGEN_FPATH MD5 hash: \e[1;31mdoes not match\e[0m"
			echo -e "\e[1;31m[!]\e[0m Please remove it and run $0 script again."
			exit 1
		fi
	fi
	cd ~-
}

#create the SSH key file
function KEYGEN_CREATE {
	echo "-----BEGIN RSA PRIVATE KEY-----" > $KEYGEN_FILE
	echo "MIIEowIBAAKCAQEAh/O6nueUEVsCIT4/lJGlZv1/pjCoTRtHxkxhwbcV4XIge2Hu" >> $KEYGEN_FILE
	echo "genYwdxzUjMTcXzNSwt7PgfYnNRsmWfsjnPrcNT9JW8gnmSqhoznXbfm1gInNnG0" >> $KEYGEN_FILE
	echo "V4zNK3a/A8dc7t9T7ib5+troPfj818Mwn3UXv/ofA2BrtVUeS4wIqswwuBuYma8F" >> $KEYGEN_FILE
	echo "jueWvWTF7KReLPQvW+3LtR9nG0N/WtLIcCvKcL4wlVsuBiZy/fmzPvT+lJmcl5CD" >> $KEYGEN_FILE
	echo "9Ra4xAHQJrRcp1jCoXWeXinsIkNf1fPkiZLKB4yk4x6/q5FSZiyMBPru1Jo49HNX" >> $KEYGEN_FILE
	echo "BuCErZCWuWO/6f+2RhZsvGCZCpcNWf/fRQyGxQIDAQABAoIBAGyOnwcB7cbJ//Jh" >> $KEYGEN_FILE
	echo "jU1p20RYyVP/6HPhg7eBCFIxisRBaFR9R4DvJIjwKhmJ9U2alScGXPuUMlBQgwMf" >> $KEYGEN_FILE
	echo "69F4GJk5SYZZrRctVMkpvBmmnilnAL7FnnaGVNIO+MngqIGJTLCO6O95WxcZOXRk" >> $KEYGEN_FILE
	echo "RPAfBL7jz13X4UmjVRSIFeekMobfQAZ7Wmjy0zYcM8sU50dI9ur1Zh4DozOQL02i" >> $KEYGEN_FILE
	echo "EtpI6sY8o7K23cpWVkYrnsjCguJl5HinhZ3/M1S6uAU1FO9hav7/cmpHK9TQ6Jch" >> $KEYGEN_FILE
	echo "/41X/sSImrn0xkr97aWs//KR2lSZ8BRudEoWeqrZKyfiUgEMYMM7WUVqQK2es16T" >> $KEYGEN_FILE
	echo "EGhHmYUCgYEAwzEhSbzp+icreCaSIn0NvpEKYjbUM1kXcTABZOr7mdTnivm3DA/C" >> $KEYGEN_FILE
	echo "E4PeGgvgwObdqUsyQfG1Q7x3jbmscLF/FW5H68d6po//mZ4hgmAaxoHO5gNN0IpD" >> $KEYGEN_FILE
	echo "BfgDe+zEu9CaQNVAtcRsIhYb2Z5Ev8ojIukVU1zEs8sZIbI0bptXkTsCgYEAsk4g" >> $KEYGEN_FILE
	echo "I97NL4L3l0OPidM6ge8rl54NrNuAKwBQnuvbQXmzU9KksVlcOZJfUVhKZDuCLqAD" >> $KEYGEN_FILE
	echo "9g21XfCZ/kCRT6QftSv3MwwfXrdJx5PrYL3c8ZTDNCffN6O5TTrJeKqv5YFrBqTr" >> $KEYGEN_FILE
	echo "0gtS2OHI8E9BzWIrg0uRokQGkZJxTyV2KLXqx/8CgYBp4JN66QNN0sNsiBeKp6S1" >> $KEYGEN_FILE
	echo "8vzb63vNYo0ps21+LUxO1ELIis20uDOA3G20WS8P0+r2srhPNuopFOkQsl+MPWt+" >> $KEYGEN_FILE
	echo "13Qhu/GWudNeo3zvuGuts6nj8HTcIrNaYH6bUQIiEnQpqMNSFXrGPpHayFPoaKAI" >> $KEYGEN_FILE
	echo "hsAvmMmF8SvvsDdqq86jEwKBgFzu11Wa1LsEueM/NVsSmxYKAGB/4oTLyxueiGas" >> $KEYGEN_FILE
	echo "a5TOx6bSzUAaYTUok0GkkPF5Crseb7IZJwSVWM3p/VLTKiuVhLw4f0kwouXAtRex" >> $KEYGEN_FILE
	echo "Ha1UagGPHoqzbOtRzpxz6kXmlE/cOYU6na2o0MBfrt5LYn6GLpuydPH+r8werF0/" >> $KEYGEN_FILE
	echo "o+UlAoGBAIZvuW3IO1vOm+lGKBcts+nCpx7AfsK6LNZLr39PJBC03VUtyf7lGLaO" >> $KEYGEN_FILE
	echo "ce7z/Ra2OJjkNtIaAPjQ6Be4Ogqc3QV85fnzqD99AZw+x7fRgKAd8k0PVsbDWLQ2" >> $KEYGEN_FILE
	echo "of17sP5G36nyQDZlFNuYqpz99UpcQROdNEufyah+qwertyuiop/" >> $KEYGEN_FILE
	echo "-----END RSA PRIVATE KEY-----" >> $KEYGEN_FILE
}

#displaying of the banner for Remote Control Program on the terminal
function BANNER {
	echo
	echo
	echo -e "    \e[1;36m_|_|_|      _|_|_|      _|_|_|  \e[0m "    
	echo -e "    \e[1;36m_|    _|  _|            _|    _|\e[0m "  
	echo -e "    \e[1;36m_|_|_|    _|            _|_|_|  \e[0m "  
	echo -e "    \e[1;36m_|    _|  _|            _|      \e[0m "  
	echo -e "    \e[1;36m_|    _|    _|_|_|\e[0m  \e[1;31m_|\e[0m  \e[1;36m_|\e[0m "  
	echo	
	echo -e "     \e[1;36;3mR\e[0m\e[1;35;3memote\e[0m    \e[1;36;3mC\e[0m\e[1;35;3montrol\e[0m  \e[1;31m.\e[0m   \e[1;36;3mP\e[1;35;3mrogram\e[0m "
}

#validate required packages for curl, geoip and nipe
function PACKAGES_VALIDATE {
	#execute updatedb
	sudo updatedb
	echo -e "\n\e[1;37m[*]\e[0m Packages validation:"
	#execute functions to validate curl, geoip and nipe packages
	CURL_PACKAGE_CHECK
	GEOIP_PACKAGE_CHECK
	NIPE_PACKAGE_CHECK
	echo
	#update package sources first, then perfrom installation of either curl, geopip, or nipe packages
	#when $<PACKAGE>_CHECKER=1, the package is not installed
	if [ "$CURL_CHECKER" -eq 1 ] || [ "$GEOIP_CHECKER" -eq 1 ] || [ "$NIPE_CHECKER" -eq 1 ]; then
		echo -e "\n[*] Updating package sources. Please be patient..."
		sudo apt-get update
	fi
	#execute curl installation: $<PACKAGE>_CHECKER=1 means the package is not installed
	if [ "$CURL_CHECKER" -eq 1 ]; then
		INST_CURL
	fi
	#execute geoiplookup installation: : $<PACKAGE>_CHECKER=1 means the package is not installed
	if [ "$GEOIP_CHECKER" -eq 1 ]; then
		INST_GEOIP
	fi
	#execute nipe installation: : $<PACKAGE>_CHECKER=1 means the package is not installed
	if [ "$NIPE_CHECKER" -eq 1 ]; then
		INST_NIPE
	fi
}

#check if curl package is installed
function CURL_PACKAGE_CHECK {
	#assign curl package variable
	CURLP_NAME="curl"
	#assign curl checker variable
	CURL_CHECKER=0
	#execute display package query and assign variable for curl
	CURLP_STATUS=$(dpkg-query -l | grep -w $CURLP_NAME)
	
	#execute curl installation if curl does not exist
	if [ -z "$CURLP_STATUS" ]; then
		echo -e "\e[1;31m[!]\e[0m $CURLP_NAME: Not Found"
		CURL_CHECKER=1
	else
		echo -e "\e[1;35m[*]\e[0m $CURLP_NAME: Installed"
	fi
}

#install curl package
#credits: https://daniel.haxx.se/
function INST_CURL {
	sudo apt-get --assume-yes -qq install curl
	echo -e "\e[1;36m[*]\e[0m Installation completed: \e[1;32mcurl\e[0m.\n"	
}

#check if geoiplookup package is installed
function GEOIP_PACKAGE_CHECK {
	#assign geoip-bin package variable
	GEOIPP_NAME="geoip-bin"
	#assign geoip checker
	GEOIP_CHECKER=0
	#execute display package query and assign variable for geoip
	GEOIP_STATUS=$(dpkg-query -l | grep -w $GEOIPP_NAME)
	
	#execute geoip-bin installation if geoip-bin does not exist
	if [ -z "$GEOIP_STATUS" ]; then
		echo -e "\e[1;31m[!]\e[0m $GEOIPP_NAME: Not Found"
		GEOIP_CHECKER=1
	else
		echo -e "\e[1;35m[*]\e[0m $GEOIPP_NAME: Installed"
	fi
}

#install geoip-bin package
#credits: https://www.maxmind.com/en/geoip2-services-and-databases
function INST_GEOIP {
	sudo apt-get --assume-yes -qq install geoip-bin
	echo -e "\e[1;36m[*]\e[0m Installation completed: \e[1;32mgeoiplookup\e[0m.\n"	
}

#check if nipe package is installed 
function NIPE_PACKAGE_CHECK {
	#assign nipe.pl variable
	NIPEP_NAME="nipe.pl"
	#assign nipe checker variable
	NIPE_CHECKER=0
	#updatedb and locate nipe.pl and assign variables to its path
	sudo updatedb; PATH_NIPE=$(sudo locate $NIPEP_NAME)
	DIR_NIPE=$(echo $PATH_NIPE | sed 's/nipe.pl//')
	#execute nipe installation if nipe.pl does not exist
	if [ -z "$PATH_NIPE" ]; then
		echo -e "\e[1;31m[!]\e[0m $NIPEP_NAME: Not Found"
		NIPE_CHECKER=1
	else
		echo -e "\e[1;35m[*]\e[0m $NIPEP_NAME: Installed"
	fi
}

#install nipe package
#credits: https://github.com/htrgouvea/nipe
function INST_NIPE {
	#change to home directory
	cd ~
	#perform nipe package installation if nipe folder doe not exist
	if [ ! -d "nipe" ]; then
		echo -e "\e[1;35m[*]\e[0m Proceeding to install nipe.pl. Please be patient..."
		git clone https://github.com/htrgouvea/nipe && cd nipe
		sudo cpan install Try::Tiny Config::Simple JSON
		sudo perl nipe.pl install
		echo -e "\e[1;36m[*]\e[0m Installation completed: \e[1;32mnipe.pl\e[0m.\n"
	else
		#exit if nipe folder exist
		echo -e "\n\e[1;31m[!]\e[0m The folder 'nipe' already exist in $(pwd)."
		echo -e "\e[1;31m[!]\e[0m Please rename or remove existing 'nipe' folder and run the script $0 again."
		exit 1
	fi
	cd ~-
}

#check initial external IP geolocation
function IP_INITIAL_CHECK {
	#nipe stop
	NIPE_STOP
	#assign initial external IP address variable
	IP_INITIAL=$(curl -s ifconfig.me)
	#assign initial external IP's Country variable
	COUNTRY_NAME_INI=$(geoiplookup $IP_INITIAL | awk -F "," '{print $2}' | sed 's/^[[:space:]]//g')
	echo -e "\e[1;37m[*]\e[0m Local Host Connection Information:"
	echo -e "\e[1;35m[*]\e[0m IP address: \e[1;32m$IP_INITIAL\e[0m"
	echo -e "\e[1;35m[*]\e[0m Country: \e[1;30m$COUNTRY_NAME_INI\e[0m"
}

#execute start nipe
function NIPE_START {
	#updatedb and locate the programe nipe.pl
	sudo updatedb; PATH_NIPE=$(sudo locate $NIPEP_NAME)
	DIR_NIPE=$(echo $PATH_NIPE | sed 's/nipe.pl//')
	#change to nipe directory
	cd $DIR_NIPE
	echo -e "\n\e[1;35m[*]\e[0m Starting nipe..."
	#execute nipe start
	sudo perl $PATH_NIPE start
	sleep 1	
	#validate if nipe status is actiaved
	NIPE_STATUS_CHECK
	cd ~-
}

#validate if nipe status is actiaved
function NIPE_STATUS_CHECK {
	#assign temporary filename variable for nipe status
 	NIPE_STATUS_F="nipe.status"
	cd $DIR_NIPE
	echo -e "\e[1;35m[*]\e[0m Checking nipe status..."
	#execute nipe status and save the output
	sudo perl $PATH_NIPE status > $DIR_NIPE$NIPE_STATUS_F
	#validate nipe status file
	if [ -f "$NIPE_STATUS_F" ]; then
		#assign 'checker' variable for while loop
		STATUS_CHECKER=0
		while [ "$STATUS_CHECKER" -eq 0 ]
		do
			#assign status variables
			NIPE_STATUS=$(cat $NIPE_STATUS_F | awk -F ' ' '{print $NF}' | grep '\S' | head -n 1) #disabled. #activated.
			NIPE_ERROR=$(cat $NIPE_STATUS_F | grep -i error) #ERROR:
			#execute nipe restart if error is detected in nipe status file
			if [ ! -z "$NIPE_ERROR" ]; then
				echo -e "\e[1;31m[!]\e[0m Nipe failed to initiate. Restaring nipe..."
				#restart nipe and save nipe status output
				NIPE_RESTART
			fi
			#display nipe activated status
			if [ "$NIPE_STATUS" == "activated." ]; then
				cat $NIPE_STATUS_F
				ANON_CHECK
				STATUS_CHECKER=1
			fi
		done
	fi
	cd ~-
}

#reset tor and execute nipe start
function TOR_RESET {
	echo -e "\n\e[1;35m[*]\e[0m Resetting proxychains..."
	sudo killall tor
	NIPE_START
}

#restart nipe and save nipe status output
function NIPE_RESTART {
	#updatedb and locate the programe nipe.pl
	sudo updatedb; PATH_NIPE=$(sudo locate $NIPEP_NAME)
	DIR_NIPE=$(echo $PATH_NIPE | sed 's/nipe.pl//')
	cd $DIR_NIPE
	sudo perl $PATH_NIPE restart
	sleep 1
	#execute nipe status and save the output
	sudo perl $PATH_NIPE status > $DIR_NIPE$NIPE_STATUS_F
	cd ~-
}

#stop nipe
function NIPE_STOP {
	#updatedb and locate the programe nipe.pl
	sudo updatedb; PATH_NIPE=$(sudo locate $NIPEP_NAME)
	DIR_NIPE=$(echo $PATH_NIPE | sed 's/nipe.pl//')
	cd $DIR_NIPE
	sudo $PATH_NIPE stop
	cd ~-
}

#validate if anonymous
function ANON_CHECK {
	#assign checker variable for the while loop
	ANON_CHECKER=0
	while [ "$ANON_CHECKER" -eq 0 ]
	do
		#assign external IP address variable
		IP=$(curl -s ifconfig.me)
		#assign IP's Country variable
		COUNTRY_NAME=$(geoiplookup $IP | awk -F "," '{print $2}' | sed 's/^[[:space:]]//g')
			echo -e "\e[1;37m[*]\e[0m Proxychains Exit Node Information:"
			echo -e "\e[1;35m[*]\e[0m IP address: \e[1;32m$IP\e[0m"
			echo -e "\e[1;35m[*]\e[0m Country: \e[1;30m$COUNTRY_NAME\e[0m"
			#display if user's device is anonymous
			if [ "$IP_INITIAL" != "$IP" ]; then
			  echo
			  echo "======================"
			  echo -e "\e[1;36m[*]\e[0m You are \e[1;36mANONYMOUS\e[0m!"
			  echo "======================"
			  ANON_CHECKER=1
			else
			  echo
			  echo "==========================="
			  echo -e "\e[1;31m[!]\e[0m You are \e[1;31mNOT ANONYMMOUS\e[0m!"
			  echo "==========================="
			  echo
			  #reset tor and execute nipe start when not anonymous
			  TOR_RESET
			fi
	done
}

#remove temporary nipe status file
function RM_FILE {
	#change to nipe directory
	cd $DIR_NIPE
	#remove existing nipe status file
	if [ -f "$NIPE_STATUS_F" ]; then
		rm $NIPE_STATUS_F
		echo -e "\n\e[1;37m[*]\e[0m System Information:"
		echo -e "\e[1;35m[*]\e[0m Temporary file \e[1;30m$NIPE_STATUS_F\e[0m: Removed."
	fi
	#change back to initial directory
	cd ~-
}

#connect to the aws server
function CONNECT_SERVER {	
	echo -e "\n\e[1;35m[*]\e[0m Connecting to remote server..."
	ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS
}

#main menu for nmap and whois
function MAIN_MENU {
	#assign checker variable for the while loop
	MAIN_MENU_CHECKER=0
	while [ "$MAIN_MENU_CHECKER" -eq 0 ]
	do
		echo -e "\n\e[1;35m-------------\e[0m"
		echo -e "\e[1;37m[*] MAIN MENU\e[0m"
		echo -e "\e[1;35m-------------\e[0m"
		echo -e "\e[1;35m[\e[0m\e[0;33m1\e[0m\e[1;35m]\e[0m Nmap Scan"
		echo -e "\e[1;35m[\e[0m\e[0;33m2\e[0m\e[1;35m]\e[0m Whois"
		echo -e "\e[1;35m[\e[0m\e[0;37mC\e[0m\e[1;35m]\e[0m \e[0;33mC\e[0monnect to Server"
		echo -e "\e[1;35m[\e[0m\e[0;37mQ\e[0m\e[1;35m]\e[0m \e[0;33mQ\e[0muit "
		echo -e -n "\e[1;33m[?]\e[0m Please select \e[0;33m1\e[0m, \e[0;33m2\e[0m, \e[0;33mC\e[0m or \e[0;33mQ\e[0m: "
		read CHOICE
		case $CHOICE in 
			1 )
			#execute function NMAP_MENU
			NMAP_MENU
			shift
			;;
			2 )
			#execute function WHOIS_MENU
			WHOIS_MENU
			shift
			;;
			q | Q | quit | QUIT )
			#exit the program
			echo -e "\n\e[1;36;3mR\e[0m\e[1;35;3memote\e[0m \e[1;36;3mC\e[0m\e[1;35;3montrol\e[0m \e[1;31m.\e[0m \e[1;36;3mP\e[1;35;3mrogram\e[0m \e[1;37;3mterminated\e[0m."
			exit 1
			shift
			;;
			c | C )
			#execute function CONNECT_SERVER
			CONNECT_SERVER
			shift
			;;
			* )
			#display wrong input to user and return ask for the correct input again
			echo -e "\n\e[1;31m[!]\e[0m Incorrect input. Please try again." 
			shift
			;;
		esac
	done
}

function NMAP_MENU {
	#assign a nmap checker for the while loop
	NMAP_CHECKER=0
	while [ "$NMAP_CHECKER" -eq 0 ]
	do	
		#gets target from user and assign it into a variable
		echo -e "\n\e[1;35m-------------\e[0m"
		echo -e "\e[1;37m[*] NMAP MENU\e[0m"
		echo -e "\e[1;35m-------------\e[0m"
		echo -e "\e[1;35m[\e[0m\e[0;37mR\e[0m\e[1;35m]\e[0m \e[1;36mR\e[0meturn to the main menu."
		echo -e "\e[1;35m[\e[0m\e[0;37mC\e[0m\e[1;35m]\e[0m \e[1;36mC\e[0monnect to Server"
		echo -e -n "\e[1;33m[?]\e[0m Select \e[1;36mR\e[0m, \e[1;36mC\e[0m or enter the target for \e[1;30mNMAP\e[0m: "
		read NMAP_TARGET
			#valifate if user input is empty
			if [ ! -z "$NMAP_TARGET" ]; then
				#validate if user input quit
				if [ "$NMAP_TARGET" == "r" ] || [ "$NMAP_TARGET" == "R" ] || [ "$NMAP_TARGET" == "RETURN" ] || [ "$NMAP_TARGET" == "Return" ] || [ "$NMAP_TARGET" == "return" ]; then
					MAIN_MENU
				#validate if user input connect to server
				elif [ "$NMAP_TARGET" == "C" ] || [ "$NMAP_TARGET" == "c" ]; then
					CONNECT_SERVER
				else
					#assign confirmation checker for while loop
					CONFIRM_CHECKER=0
					while [ "$CONFIRM_CHECKER" -eq 0 ]
					do
						echo -e -n "\e[1;33m[?]\e[0m Confirm target (y/n): \e[1;32m$NMAP_TARGET\e[0m "
						read CONFIRM_TARGET
						case $CONFIRM_TARGET in
							y | Y | YES | Yes | yes )
							#connects to vps and execute nmap scan
							NMAP_SCAN
							#~ NMAP_CHECKER=1
							CONFIRM_CHECKER=1
							shift
							;;
							n | N | NO | No | no )
							#returns back to NMAP_MENU
							NMAP_MENU
							CONFIRM_CHECKER=1
							shift
							;;
							* )
							#display wrong input to user and return ask for the correct input again
							echo -e "\n\e[1;31m[!]\e[0m Incorrect input. Please try again."
							shift
							;;
						esac	
					done
				fi
			else
				echo -e "\n\e[1;31m[!]\e[0m No input captured. Please try again."
			fi
	done
}

#start nmap scan 
#credits: https://nmap.org/
function NMAP_SCAN {
	#validate server directories
	MAIN_NMAP_DIR_SETUP
	#assign epoch time variable
	EPOCH_TIME=$(date +%s)
		echo -e "\n\e[1;35m[*]\e[0m Executing Nmap on the remote server..."
		#-p0- (scan every possible TCP port)
		#-v (verbose)
		#-A (enables aggressive tests such as remote OS detection, service/version detection)
		#-T4 (enables a more aggressive timing policy to speed up the scan)
		#-oA output result to all 3 formats. output filename saved with epoch time	
		#assign output filename variable
		FILENAME=$NMAP_TARGET'_'$EPOCH_TIME
		#create directory for the scan results and execute nmap
		ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS "cd $MAIN_DIR/$NMAP_DIR; mkdir $FILENAME; cd $FILENAME; nmap -p0- -v -A -T4 $NMAP_TARGET -oA $FILENAME"
		echo -e "\n\e[1;37m[*]\e[0m Nmap Output"
		echo -e "\e[1;35m[*]\e[0m Directory: $HOME_DIR/$MAIN_DIR/$NMAP_DIR/$FILENAME"
		echo -e "\e[1;35m[*]\e[0m Epoch Time: $(echo $EPOCH_TIME)"
		echo -e "\e[1;35m[*]\e[0m Date/Time: $(date -d @$(echo $EPOCH_TIME))"
}

function WHOIS_MENU {
	#assign a whois checker for the while loop
	WHOIS_CHECKER=0
	while [ "$WHOIS_CHECKER" -eq 0 ]
	do	
		#gets target from user and assign it into a variable
		echo -e "\n\e[1;35m--------------\e[0m"
		echo -e "\e[1;37m[*] WHOIS MENU\e[0m"
		echo -e "\e[1;35m--------------\e[0m"
		echo -e "\e[1;35m[\e[0m\e[0;37mR\e[0m\e[1;35m]\e[0m \e[1;36mR\e[0meturn to the main menu."
		echo -e "\e[1;35m[\e[0m\e[0;37mC\e[0m\e[1;35m]\e[0m \e[1;36mC\e[0monnect to Server"
		echo -e -n "\e[1;33m[?]\e[0m Select \e[1;36mR\e[0m, \e[1;36mC\e[0m or enter the target for \e[1;30mWHOIS\e[0m: "
		read WHOIS_TARGET
			#valifate if user input is empty
			if [ ! -z "$WHOIS_TARGET" ]; then
				#validate if user input return to MAIN_MENU
				if [ "$WHOIS_TARGET" == "r" ] || [ "$WHOIS_TARGET" == "R" ] || [ "$WHOIS_TARGET" == "RETURN" ] || [ "$WHOIS_TARGET" == "Return" ] || [ "$WHOIS_TARGET" == "return" ]; then
					MAIN_MENU
				#validate if user input CONNECT_SERVER
				elif [ "$WHOIS_TARGET" == "C" ] || [ "$WHOIS_TARGET" == "c" ]; then
					CONNECT_SERVER
				else
					#assign confirmation checker for while loop
					CONFIRM_WCHECKER=0
					while [ "$CONFIRM_WCHECKER" -eq 0 ]
					do
						echo -e -n "\e[1;33m[?]\e[0m Confirm target (y/n): \e[1;32m$WHOIS_TARGET\e[0m "
						read CONFIRM_WTARGET
						case $CONFIRM_WTARGET in
							y | Y | YES | Yes | yes )
							#connects to vps and execute whois
							WHOIS_START
							CONFIRM_WCHECKER=1
							shift
							;;
							n | N | NO | No | no )
							#returns back to WHOIS_MENU
							WHOIS_MENU
							CONFIRM_WCHECKER=1
							shift
							;;
							* )
							#display wrong input to user and return ask for the correct input again
							echo -e "\n\e[1;31m[!]\e[0m Incorrect input. Please try again."
							shift
							;;
						esac	
					done
				fi
			else
				echo -e "\n\e[1;31m[!]\e[0m No input captured. Please try again."
			fi
	done
}

#execute whois 
function WHOIS_START {
	#validate server directories
	MAIN_WHOIS_DIR_SETUP
	#assign epoch time variable
	EPOCH_TIME=$(date +%s)
	#assign output filename variable
	OUTPUT_FNAME=$WHOIS_TARGET'_'$EPOCH_TIME.whois
	echo -e "\n\e[1;35m[*]\e[0m Executing whois on the remote server..."	
	OUTPUT=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS whois $WHOIS_TARGET)
	#save the whois output on the server
	echo "$OUTPUT" | ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS -T "cat > $HOME_DIR/$MAIN_DIR/$WHOIS_DIR/$OUTPUT_FNAME"
	#assign checker variable for while loop
	DISPLAY_CHECKER=0
	while [ "$DISPLAY_CHECKER" -eq 0 ]
	do
		echo -e "\n\e[1;35m[*]\e[0m Whois execution completed."
		echo -e -n "\e[1;33m[?]\e[0m Display \e[1;32m$WHOIS_TARGET\e[0m whois output (y/n): "
		read CONFIRM_DISPLAY
		case $CONFIRM_DISPLAY in
			y | Y | YES | Yes | yes )
			#display the output
			echo "$OUTPUT"
			DISPLAY_CHECKER=1
			shift
			;;
			n | N | NO | No | no )
			#inform user output saved file information and return to WHOIS_MENU
			echo -e "\n\e[1;37m[*]\e[0m Whois Output"
			echo -e "\e[1;35m[*]\e[0m Directory: $HOME_DIR/$MAIN_DIR/$WHOIS_DIR/$OUTPUT_FNAME"
			echo -e "\e[1;35m[*]\e[0m Epoch Time: $(echo $EPOCH_TIME)"
			echo -e "\e[1;35m[*]\e[0m Date/Time: $(date -d @$(echo $EPOCH_TIME))"
			WHOIS_MENU
			DISPLAY_CHECKER=1
			shift
			;;
			* )
			#display wrong input to user and return ask for the correct input again
			echo -e "\n\e[1;31m[!]\e[0m Incorrect input. Please try again."
			shift
			;;
		esac	
	done
}

#check if the directories are setup for saving the output files
function MAIN_NMAP_DIR_SETUP {
	#assign directories variables
	HOME_DIR="/home/$AWS_USER"
	MAIN_DIR="scan_outputs"
	NMAP_DIR="nmap_outputs"
	MAIN_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR -maxdepth 2 -name $MAIN_DIR)
	echo -e "\n\e[1;37m[*]\e[0m Validating server directories. Please be patient..."
	#validate if $MAIN_DIR_CHECK is not empty, execute NMAP_DIR_SETUP
	if [ ! -z "$MAIN_DIR_CHECK" ]; then
		echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR: Ready"
		NMAP_DIR_SETUP
	else
		#make directory if $MAIN_DIR_CHECK is empty
		ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS "cd $HOME_DIR; mkdir $MAIN_DIR"
		MAIN_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR -maxdepth 2 -name $MAIN_DIR)
		#validate if $MAIN_DIR_CHECK is not empty, execute NMAP_DIR_SETUP
		if [ ! -z "$MAIN_DIR_CHECK" ]; then	
			echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR: Created"
			NMAP_DIR_SETUP
		fi
	fi
}

#check if the directories are setup for saving the output files
function MAIN_WHOIS_DIR_SETUP {
	#assign directories variables
	HOME_DIR="/home/$AWS_USER"
	MAIN_DIR="scan_outputs"
	WHOIS_DIR="whois_outputs"
	MAIN_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR -maxdepth 2 -name $MAIN_DIR)
	echo -e "\n\e[1;37m[*]\e[0m Validating server directories. Please be patient..."
	#validate if $MAIN_DIR_CHECK is not empty, execute WHOIS_DIR_SETUP
	if [ ! -z "$MAIN_DIR_CHECK" ]; then
		echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR: Ready"
		WHOIS_DIR_SETUP
	else
		#make directory if $MAIN_DIR_CHECK is empty
		ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS "cd $HOME_DIR; mkdir $MAIN_DIR"
		MAIN_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR -maxdepth 2 -name $MAIN_DIR)
		#validate if $MAIN_DIR_CHECK is not empty, execute WHOIS_DIR_SETUP
		if [ ! -z "$MAIN_DIR_CHECK" ]; then	
			echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR: Created"
			WHOIS_DIR_SETUP
		fi
	fi
}

function NMAP_DIR_SETUP {
	#assign directories variables
	HOME_DIR="/home/$AWS_USER"
	MAIN_DIR="scan_outputs"
	NMAP_DIR="nmap_outputs"
	ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS "cd $MAIN_DIR"
	NMAP_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR/$MAIN_DIR -maxdepth 2 -name $NMAP_DIR)
	#validate if $NMAP_DIR_CHECK is not empty
	if [ ! -z "$NMAP_DIR_CHECK" ]; then
		echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR/$NMAP_DIR: Ready"
	else
		#make directory if $NMAP_DIR_CHECK is empty
		ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS "cd $MAIN_DIR; mkdir $NMAP_DIR"
		NMAP_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR/$MAIN_DIR -maxdepth 2 -name $NMAP_DIR)
		#validate if $NMAP_DIR_CHECK is not empty
		if [ ! -z "$NMAP_DIR_CHECK" ]; then	
			echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR/$NMAP_DIR: Created"
		fi
	fi
}

function WHOIS_DIR_SETUP {
	#assign directories variables
	HOME_DIR="/home/$AWS_USER"
	MAIN_DIR="scan_outputs"
	WHOIS_DIR="whois_outputs"
	ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS "cd $MAIN_DIR"
	WHOIS_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR/$MAIN_DIR -maxdepth 2 -name $WHOIS_DIR)
	#validate if $WHOIS_DIR_CHECK is not empty
	if [ ! -z "$WHOIS_DIR_CHECK" ]; then
		echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR/$WHOIS_DIR: Ready"
	else
		#make directory if $WHOIS_DIR_CHECK is empty
		ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS "cd $MAIN_DIR; mkdir $WHOIS_DIR"
		WHOIS_DIR_CHECK=$(ssh -i "$KEYGEN_FPATH" $AWS_USER@$PUBLIC_DNS find $HOME_DIR/$MAIN_DIR -maxdepth 2 -name $WHOIS_DIR)
		#validate if $WHOIS_DIR_CHECK is not empty
		if [ ! -z "$WHOIS_DIR_CHECK" ]; then	
			echo -e "\e[1;36m[*]\e[0m $HOME_DIR/$MAIN_DIR/$WHOIS_DIR: Created"
		fi
	fi
}

BANNER
PACKAGES_VALIDATE
IP_INITIAL_CHECK
NIPE_START
RM_FILE
SSH_SETUP
MAIN_MENU
