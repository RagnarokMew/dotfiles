#!/bin/bash

if $(dunstctl is-paused); then
  icon="󰂛"
else
  icon="󰂚"
fi

tooltip="Pending Notifications: $(dunstctl count waiting)"

# Module and tooltip
echo "{\"text\": \"${icon}\", \"tooltip\": \"${tooltip}\"}"
