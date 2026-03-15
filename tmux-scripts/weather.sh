#!/bin/bash
# Cached weather for tmux status bar (refreshes every 15 minutes)
CACHE_FILE="/tmp/tmux-weather-cache"
CACHE_MAX_AGE=900 # 15 minutes in seconds

if [ -f "$CACHE_FILE" ]; then
    cache_age=$(( $(date +%s) - $(stat -f %m "$CACHE_FILE") ))
    if [ "$cache_age" -lt "$CACHE_MAX_AGE" ]; then
        cat "$CACHE_FILE"
        exit 0
    fi
fi

weather=$(curl -s --max-time 5 "wttr.in/?format=%c+%C+%t++💧%h++💨%w" 2>/dev/null | tr -d '+' | sed 's/  */ /g')
if [ -n "$weather" ] && ! echo "$weather" | grep -q "Unknown"; then
    echo "$weather" > "$CACHE_FILE"
    echo "$weather"
else
    [ -f "$CACHE_FILE" ] && cat "$CACHE_FILE" || echo "N/A"
fi
