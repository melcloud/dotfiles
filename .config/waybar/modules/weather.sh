#!/usr/bin/env sh

cachedir=~/.cache/waybar/wttr
cachefile="$cachedir/${0##*/}-${1:-default}"

if [ ! -d "$cachedir" ]; then
	mkdir -p "$cachedir"
fi

if [ ! -f "$cachefile" ]; then
	touch "$cachefile"
fi

cacheAge=$(($(date +%s) - $(stat -c '%Y' "$cachefile")))
if [ $cacheAge -gt 1740 ] || [ ! -s "$cachefile" ]; then
	curl -s --compressed https://en.wttr.in/"$1"\?format=%c+%t+%w+%p+%o >"$cachefile" 2>&1
fi

tooltip=$(cat "$cachefile")
weather=$(echo "$tooltip" | cut -d ' ' -f 1-2)

echo "{\"text\":\"$weather\", \"tooltip\":\"$tooltip\", \"class\": \"weather\", \"percentage\":\"\"}"
