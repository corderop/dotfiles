#!/bin/bash

# Create rofi folder if does not exists
mkdir -p ~/.config/rofi/
mkdir -p ~/.local/share/rofi/themes

# Get the themes
git clone https://github.com/lr-tech/rofi-themes-collection

# Copy the themes
cp -r rofi-themes-collection/themes/. ~/.local/share/rofi/themes/

# Remove the cloned  dir
rm -f -r rofi-themes-collection
