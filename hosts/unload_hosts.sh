#!/bin/bash

# Check if is runned with root priviledges
ROOTUID="0"
if [ "$(id -u)" -ne "$ROOTUID" ] ; then
	echo "This script must be executed with root privileges."
    exit 1
fi

cp "/etc/hosts.default" "/etc/hosts"
printf "✅ Default profile selected\n"