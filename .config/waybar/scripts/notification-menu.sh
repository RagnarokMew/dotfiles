#!/usr/bin/env bash

# Get dunstctl history in JSON
raw=$(dunstctl history)

# Parse with jq:
# Show only id, app, and summary (no body)
notifications=$(echo "$raw" | jq -r '
  .data[0][] 
  | "[\(.id.data)] [\(.appname.data)] — \(.summary.data | gsub("\n"; " "))"'
)

# Add "Clear All" option
menu=$(printf "%s\n%s" "󰆴  Clear All History" "$notifications")

# Show in rofi
selection=$(echo "$menu" | rofi -dmenu -i -p "Notifications" -theme ~/.config/rofi/notifications.rasi)

if [ -z "$selection" ]; then
    exit 0
fi

# Handle clear all
if [[ "$selection" == "󰆴  Clear All History" ]]; then
    dunstctl history-clear
    exit 0
fi

# Extract ID (inside [ ])
id=$(echo "$selection" | sed -n 's/^\[\([0-9]\+\)\].*/\1/p')

# Replay chosen notification
if [ -n "$id" ]; then
    dunstctl history-pop "$id"
fi

