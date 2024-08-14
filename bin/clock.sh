#!/bin/sh
# Command-line world clock
# Taken from  http://stackoverflow.com/questions/370075/command-line-world-clock

# .worldclock.zones file looks like:
# US/Pacific
# Europe/Berlin
# Chile/Continental

: ${WORLDCLOCK_ZONES:=$HOME/.worldclock.zones}
: ${WORLDCLOCK_FORMAT:='+%Y-%m-%d %H:%M:%S %Z'}

if [ ! -f "$WORLDCLOCK_ZONES" ]; then
    echo 'Australia/Sydney
Asia/Shanghai
Asia/Tokyo
Europe/London
Europe/Paris
US/Pacific
US/Eastern' >$WORLDCLOCK_ZONES
fi

while true; do
    clear
    while read zone; do
        echo $zone '!' $(TZ=$zone date "$WORLDCLOCK_FORMAT")
    done <$WORLDCLOCK_ZONES |
        awk -F '!' '{ printf "%-20s  %s\n", $1, $2;}'
    sleep 1
done
