#!/bin/sh
killall swaybg
swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &

