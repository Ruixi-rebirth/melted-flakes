#!/bin/sh
killall waybar

for i in /sys/class/hwmon/hwmon*/temp*_input; do 
    if [ "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "coretemp: Core 0" ]; then
        export HWMON_PATH="$i"
    fi
done

sed -i "/hwmon-path/c\ \ \ \ \"hwmon-path\": \"$HWMON_PATH\"," $SDIR/config

#waybar -c "$SDIR"/config1 -s "$SDIR"/style1.css &
waybar
