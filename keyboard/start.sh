#!/bin/bash

sleep 2
xkbcomp ~/.dotfiles/keyboard/layout.xkb ":0" > /dev/null 2>&1