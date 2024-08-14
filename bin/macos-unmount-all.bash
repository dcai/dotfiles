#!/bin/bash
# https://stackoverflow.com/a/53443327/69938
osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
