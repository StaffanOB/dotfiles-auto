#!/usr/bin/env bash
# Script Name: install-packages.sh
# Description: Sources install file with information for instructions for 
# installing a package form each directory.
# Dependencies: 
# Author: Staffan Bjornson <staffan@toor.se> 


LOG_FILE=~/install-packages.log
DATE=$(date '+%Y-%m-%d %H:%M:%S')
DOTD=$(cd -- "$(dirname -- "${BASH_source[0]}" )" &> /dev/null && pwd)
DIRS=()             # List of all directorys
SLINK=()            # Source link path
DLINK=()            # Destination link path


# Check if it is a Debian distro
if ! type -p apt > /dev/null; then
    echo "APT is not installed, is it a Debian based distro?"
    exit 1
fi

# Get all directorys with a install.sh file
for i in $(ls -d */); do 
	if test -f "${i}install.sh"; then
		DIRS+=(${i%%/})
	fi
done

# Iterate each directory and source the install file
for i in "${DIRS[@]}"; do 
	source "$i/install.sh"

    for (( j = 0; j < ${#SLINK[@]}; j++ )); do
        rm -rf ${DLINK[$j]} > /dev/null 2>&1
        ln -s ${DOTD}/${COMMAND}/${SLINK[$j]} ${DLINK[$j]}
    done


	if type -p $COMMAND > /dev/null; then
	    echo "$DATE: $COMMAND Installed " >> $LOG_FILE
	else
	    echo "$DATE: $COMMAND failed to install" >> $LOG_FILE
	fi

    echo $DOTD
done
