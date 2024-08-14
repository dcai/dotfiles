#!/bin/bash
for file in *.webm *.wmv *.rmvb; do
    if [ -f "$file" ]; then
        echo "=> Processing \"$file\"..."
        echo "$file"
        ffmpeg -i "$file" "$file.mp4"
        rm "$file"
    else
        echo "=> Error: not valid file \"$file\""
    fi
done
