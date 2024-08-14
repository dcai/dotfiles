#!/bin/bash

ME=$(basename "$0")
T=$1

if [[ $T == 'cli' ]]; then
    sudo xcode-select -switch /Library/Developer/CommandLineTools
fi

if [[ $T == 'xcode' ]]; then
    sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
fi

echo "ERROR: no xcode selected"
echo "$ME cli or $ME xcode"
