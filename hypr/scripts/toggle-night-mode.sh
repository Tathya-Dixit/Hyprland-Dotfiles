#!/bin/zsh
if pgrep -x "hyprsunset" > /dev/null; then
    pkill hyprsunset
    notify-send "Night mode disabled"
else
    hyprsunset &
    notify-send "Night mode enabled"
fi   
