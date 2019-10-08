#!/usr/bin/env sh

set -ex

if pgrep waybar; then
	pkill waybar
	sleep 0.25

	waybar -c ~/.config/waybar/top.json >/dev/null 2>&1
else
	waybar -c ~/.config/waybar/top.json >/dev/null 2>&1
fi
