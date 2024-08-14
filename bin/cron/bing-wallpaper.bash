#!/usr/bin/env bash

# https://gist.github.com/ninehills/45e94296cb4556f9bdf7

PICTURE_DIR="$HOME/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

BING_URL="http://global.bing.com/?FORM=HPCNEN&setmkt=en-us&setlang=en-us#"
BING_URL="http://www.bing.com/?FORM=HPCNEN&setmkt=en-us"
urls=($(curl -s $BING_URL |
    grep -Eo "url:'.*?'" |
    sed -e "s/url:'\([^']*\)'.*/http:\/\/bing.com\1/" |
    sed -e "s/\\\//g"))

for p in ${urls[@]}; do
    filename=$(echo $p | sed -e "s/.*\/\(.*\)/\1/")
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $p -> $filename ..."
        curl -Lso "$PICTURE_DIR/$filename" $p
    else
        echo "Skipping: $filename ..."
    fi
done
