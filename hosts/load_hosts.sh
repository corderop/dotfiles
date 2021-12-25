#!/bin/bash

# Check if is runned with root priviledges
ROOTUID="0"
if [ "$(id -u)" -ne "$ROOTUID" ] ; then
	echo "This script must be executed with root privileges."
    exit 1
fi

if [ -z "$1" ]
then
    echo "You must specify the profile to load"
else
    cp "/etc/hosts.$1" "/etc/hosts"
    printf "✅ Profile '$1' loaded\n"
fi
