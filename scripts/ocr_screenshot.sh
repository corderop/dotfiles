#!/bin/bash 
# Make an screenshot and put the text of the screenshot 
# in the clipboard. Modified script from 
# https://askubuntu.com/questions/280475/how-can-instantaneously-extract-text-from-a-screen-area-using-ocr-tools

SCR_IMG=`mktemp`
trap "rm $SCR_IMG*" EXIT

scrot -s $SCR_IMG.png -q 100    
# increase image quality with option -q from default 75 to 100

mogrify -modulate 100,0 -resize 400% $SCR_IMG.png 
#should increase detection rate

tesseract $SCR_IMG.png $SCR_IMG &> /dev/null
echo $(cat $SCR_IMG.txt) | xsel -bi