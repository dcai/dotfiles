#!/bin/bash

# ffmpeg quick guide: https://gist.github.com/protrolium/e0dbd4bb0f1a396fcb55

MERGEDMP3="merged.mp3"
VIDEOFILE="output.mp4"

rm $MERGEDMP3
rm $VIDEOFILE
echo "merging mp3"

files=''
i=0
for mp3file in *.mp3; do
    if [ $i -eq 0 ]; then
        files="${files}${mp3file}"
    else
        files="${files}|${mp3file}"
    fi
    i=$((i + 1))
done
cmd="ffmpeg -i 'concat:$files' -acodec copy $MERGEDMP3"
echo $cmd
eval $cmd

echo "Generate mp4"
cmd="ffmpeg -shortest -loop 1 -i cover.jpg -c:a mp3 -i $MERGEDMP3 -c:v libx264 -tune stillimage -s 320x320 $VIDEOFILE"
echo $cmd
eval $cmd
