#!/bin/bash

if pgrep -x "wl-mirror" > /dev/null; then
	pkill -x "wl-mirror"
	notify-send "Mirror Screen" "Stopped projector mirroring."
	exit 0
fi

if [[ -z "$PROJECTOR_PORT" || -z "$MAIN_MONITOR_PORT" ]]; then
	notify-send "Mirror Screen" "No projector set."
	exit 1
fi

wl-mirror "$MAIN_MONITOR_PORT" &
notify-send "Mirror Screen" "Mirroring $MAIN_MONITOR_PORT to $PROJECTOR_PORT"
