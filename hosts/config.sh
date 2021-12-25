#!/bin/bash

# Check if is runned with root priviledges
ROOTUID="0"
if [ "$(id -u)" -ne "$ROOTUID" ] ; then
	echo "This script must be executed with root privileges."
    exit 1
fi


# Backup default hosts configuration if not exists
printf "📦 Doing backups\n"

BACKUP_NAME="hosts.$(date +%s)"
mkdir -p /etc/hosts.backups
cp /etc/hosts "/etc/hosts.backups/$BACKUP_NAME"
printf "  ✅ Backup of the current /etc/hosts file in /etc/hosts.backups/$BACKUP_NAME\n"
cp /etc/hosts /etc/hosts.default
printf "  ✅ Current /etc/hosts set as default hosts (/etc/hosts.default\n"

# Add new profile to the hosts
printf "\n"
printf "✨ Adding new profiles\n"

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
FILES="$USER_HOME/.dotfiles/hosts/hosts.*"
for f in $FILES
do
	cp $f /etc/.
	printf "  ✅ Profile '${f##*.}' added\n"
done
