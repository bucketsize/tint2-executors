#!/bin/sh

# Set the volume level with a zenity dialog box

# Dependencies: `alsa-utils`, `zenity`

card=$(grep "PCH" /proc/asound/cards | head -n1 | grep -oe "[0-9] ")
lvl=$(amixer -c $card sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')
lvl=${lvl::-1}
lvl=$(zenity --scale --value ${lvl} --title "Volume" --text "Set master volume level")
amixer -c $card sset 'Master' ${lvl}% -q
