#!/bin/sh -e
FILE=$(date "+%Y-%m-%d"T"%H:%M:%S").png
# Get the picture from maim
grimshot --notify  save area ~/Pictures/src.png >> /dev/null
# add shadow, round corner, border and watermark
convert $HOME/Pictures/src.png \
	\( +clone -alpha extract \
	-draw 'fill black polygon 0,0 0,8 8,0 fill white circle 8,8 8,0' \
	\( +clone -flip \) -compose Multiply -composite \
	\( +clone -flop \) -compose Multiply -composite \
	\) -alpha off -compose CopyOpacity -composite $HOME/Pictures/output.png
#
convert $HOME/Pictures/output.png -bordercolor none -border 20 \( +clone -background black -shadow 80x8+15+15 \) \
	+swap -background transparent -layers merge +repage $HOME/Pictures/$FILE
#
composite -gravity Southeast ./watermark.png $HOME/Pictures/$FILE $HOME/Pictures/$FILE 
#
# # Send the Picture to clipboard
wl-copy < $HOME/Pictures/$FILE
#
# # remove the other pictures
rm $HOME/Pictures/src.png $HOME/Pictures/output.png
