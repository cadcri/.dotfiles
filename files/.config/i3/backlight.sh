#!/bin/bash

set -e
file="/sys/class/backlight/intel_backlight/brightness"
current=$(cat "$file")
filemax="/sys/class/backlight/intel_backlight/max_brightness"
currentmax=$(cat "$filemax")
new="$current"

if [ "$1" = "-inc" ]
then
	new=$(( current + $2 ))
	if [ "$new" -ge "$currentmax" ]
	then
		new=$currentmax
	fi
fi

if [ "$1" = "-dec" ]
then
	new=$(( current - $2 ))
	if [ "$new" -le 0 ]
	then
		new=1
	fi
fi

echo "$new" | tee "$file"
