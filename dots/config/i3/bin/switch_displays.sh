#!/bin/bash -e

EXTERNAL_OUTPUT="HDMI-0"
INTERNAL_OUTPUT="eDP-1-1"
TIMEOUT=6000

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="INTERNAL"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="EXTERNAL"
	notify-send -t $TIMEOUT "DISPLAY" "HDMI"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto --primary
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
	notify-send -t $TIMEOUT "DISPLAY" "eDP1"
        xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT --off
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat
