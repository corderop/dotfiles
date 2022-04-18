#!/bin/bash

MAIN_EMOJI_URL=https://raw.githubusercontent.com/Mange/rofi-emoji/master/all_emojis.txt
TMP_FOLDER=/tmp/config_emojis
EMOJIS_FOLDER=/usr/share/rofi-emoji

mkdir -p $TMP_FOLDER
cp custom_emoji $TMP_FOLDER
cd $TMP_FOLDER

printf "\n🔒 Making backup of current emojis \n\n"
sudo cp $EMOJIS_FOLDER/all_emojis.txt $EMOJIS_FOLDER/all_emojis.txt.backup

printf "\n📦 Downloading emojis \n\n"
curl $MAIN_EMOJI_URL --output all_emojis.txt

printf "\n📄 Copying custom emojis\n\n"
cat custom_emoji >> all_emojis.txt

printf "\n🚚 Moving emojis config file\n\n"
sudo cp $TMP_FOLDER/all_emojis.txt $EMOJIS_FOLDER/all_emojis.txt