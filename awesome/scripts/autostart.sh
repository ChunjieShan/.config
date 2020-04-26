#!/bin/sh

fcitx & # Launching fcitx
picom -b # Launching picom
xbacklight -set 85
/bin/bash ~/xmodmap.sh # Launching my keyboard layouts
/bin/bash ./clash.sh # Launching proxy
