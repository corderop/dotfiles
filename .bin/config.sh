#!/bin/bash

mkdir -p ~/.bin
cp `ls | grep -v  "\."` ~/.bin # Avoid to copy configuration scripts

# Add .bin to path in bashrc
ADD_PATH="PATH=\$PATH:$HOME/.bin"

if ! grep "PATH=\$PATH:$HOME/.bin" -q ~/.bashrc
then
	echo "$ADD_PATH" >> ~/.bashrc
fi
