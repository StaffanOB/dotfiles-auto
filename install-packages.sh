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
FILES=()            # Source link path
DLINK=()            # Destination link path

echo "Installing and setting up"
# Check if it is a Debian distro
if ! type -p apt > /dev/null; then
    echo "   * ERROR: APT is not installed, is it a Debian based distro?"
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
    echo -n "   "
	source "$i/install.sh"

    # Check if command exists
	if type -p $COMMAND > /dev/null; then
	    echo "     * Installed "
	    echo "$DATE: $COMMAND Installed " >> $LOG_FILE
	else
	    echo "     * Failed to install "
	    echo "$DATE: $COMMAND failed to install" >> $LOG_FILE
	fi

    for (( j = 0; j < ${#FILES[@]}; j++ )); do
        if test -f "${DOTD}/${COMMAND}/${FILES[$j]}"; then 
    		rm -rf ${DLINK[$j]} > /dev/null 3>&1
	    	ln -s ${DOTD}/${COMMAND}/${FILES[$j]} ${DLINK[$j]}

            echo "     * Symlink to ${DOTD}/${COMMAND}/${FILES[$j]} created"
        elif test -d "${DOTD}/${FILES[$j]}"; then
    		rm -rf ${DLINK[$j]} > /dev/null 3>&1
	    	ln -s ${DOTD}/${FILES[$j]} ${DLINK[$j]}

            echo "     * Symlink to ${DOTD}/${FILES[$j]} created"
        else
            echo "     * No config file found and no links was created"
        fi
    done

    

done
