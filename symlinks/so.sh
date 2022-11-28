#!/bin/bash

# GTK
ln $1 "$HOME/.dotfiles/so/linux/gtk/gtk-2.0" "$HOME/.config/gtk-2.0"
ln $1 "$HOME/.dotfiles/so/linux/gtk/gtk-3.0" "$HOME/.config/gtk-3.0"
ln $1 "$HOME/.dotfiles/so/linux/gtk/gtk-4.0" "$HOME/.config/gtk-4.0"

# KDE
ln $1 "$HOME/.dotfiles/so/linux/kde/kglobalshortcutsrc" "$HOME/.config/kglobalshortcutsrc"
ln $1 "$HOME/.dotfiles/so/linux/kde/kwinrc" "$HOME/.config/kwinrc"
ln $1 "$HOME/.dotfiles/so/linux/kde/kxkbrc" "$HOME/.config/kxkbrc"
ln $1 "$HOME/.dotfiles/so/linux/kde/ksplashrc" "$HOME/.config/ksplashrc"
ln $1 "$HOME/.dotfiles/so/linux/kde/kdeglobals" "$HOME/.config/kdeglobals"
ln $1 "$HOME/.dotfiles/so/linux/kde/plasma/plasmashellrc" "$HOME/.config/plasmashellrc"
ln $1 "$HOME/.dotfiles/so/linux/kde/plasma/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
ln $1 "$HOME/.dotfiles/so/linux/kde/Trolltech.conf" "$HOME/.config/Trolltech.conf"

## KXMLGUI5
ln $1 "$HOME/.dotfiles/so/linux/kde/kxmlgui5" "$HOME/.local/share/kxmlgui5"

## Konsole
ln $1 "$HOME/.dotfiles/so/linux/kde/konsole/Main.profile" "$HOME/.local/share/konsole/Main.profile"
ln $1 "$HOME/.dotfiles/so/linux/kde/konsole/Breath Light Custom.colorscheme" "$HOME/.local/share/konsole/Breath Light Custom.colorscheme"
ln $1 "$HOME/.dotfiles/so/linux/kde/konsole/konsolerc" "$HOME/.config/konsolerc"

## Plasma
### Plasmoid
ln $1 "$HOME/.dotfiles/so/linux/kde/plasma/plasmoids" "$HOME/.local/share/plasma/plasmoids"

## kdedefaults
ln $1 "$HOME/.dotfiles/so/linux/kde/kdedefaults" "$HOME/.config/kdedefaults"

## ETC
sudo ln $1 "$HOME/.dotfiles/so/linux/etc/udev/rules.d/keychron-k12.rules" "/etc/udev/rules.d/keychron-k12.rules"