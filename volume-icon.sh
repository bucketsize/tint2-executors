#!/bin/sh

# This script display an appropriate volume icon according to the volume level

# Authors: Piotr Miller, @natemaia
# e-mail: nwg.piotr@gmail.com
# Website: http://nwg.pl
# Project: https://github.com/nwg-piotr/tint2-executors
# License: GPL3

# Dependencies: `alsa-utils`

card=$(grep "PCH" /proc/asound/cards | head -n1 | grep -oe "[0-9] ")
if [ "$(amixer -c $card sget Master | grep -P '(Right|Mono):.*\[on\]')" != "" ]; then

    # search for the lines containing 'Right:' or 'Mono:', when more than 1 field exists
    # we strip the trailing '%' and round it up with printf "%0.0f" just in case
    vol=$(amixer -c $card sget Master | awk -F'[][]' '/Right:|Mono:/ && NF > 1 {sub(/%/, ""); printf "%0.0f\n", $2}')

    if [ ${vol} -ge 90 ]; then
        echo ~/tint2-executors/images/vol-full.svg
    elif [ ${vol} -ge 40 ]; then
        echo ~/tint2-executors/images/vol-medium.svg
    elif [ ${vol} -ge 10 ]; then
        echo ~/tint2-executors/images/vol-low.svg
    else
        echo ~/tint2-executors/images/vol-lowest.svg
    fi
    if  [ $1 = "-l" ]; then
        echo ${vol}%
    fi
else
    echo ~/tint2-executors/images/vol-muted.svg
fi
