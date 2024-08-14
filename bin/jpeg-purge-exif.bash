#!/bin/bash
for i in *.jpg; do
    echo "Processing $i"
    #exiftool -geotag= "$i"
    exiftool -o ./out/ -all= "$i"
done
