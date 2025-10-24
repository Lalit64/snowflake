#!/usr/bin/env bash
/opt/homebrew/bin/media-control stream | \
    while IFS= read -r line; do
        if [ "$(jq -r '.diff == false' <<< "$line")" = "true" ]; then
            playing=$(jq -r '.payload.playing' <<< "$line")
            title=$(jq -r '.payload.title' <<< "$line")
            artist=$(jq -r '.payload.artist' <<< "$line")
            app=$(jq -r '.payload.bundleIdentifier' <<< "$line") 
           sketchybar --trigger media_stream_changed playing="$playing" title="$title" artist="$artist" app="$app"
        fi
    done
