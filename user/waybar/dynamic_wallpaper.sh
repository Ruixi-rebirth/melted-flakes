#!/bin/sh
killall swaybg
# Automatically change wallpaper every 10 minutes
swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
OLD_PID=$!
while true; do
    sleep 120
    swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
    NEXT_PID=$!
    sleep 5
    kill $OLD_PID
    OLD_PID=$NEXT_PID
done
