#!/bin/sh

# Only run process if not running already
run() {
    if ! pgrep -f "$1" ;
    then
        "$@"&
    fi
}

run "picom" -b
run "udiskie" --tray
run "blueman-applet"
run "nm-applet" --no-agent
run "snixembed"
run "emacs" --daemon

# Kill and run alttab, so settings apply on WM reload
pkill alttab
alttab -w 1 -d 2 -t 192x224 -i 192x96 -fg "#c5c9c5" -bg "#181616" -frame "#8ba4b0" -font "xft:Hurmit Nerd Font-11" &

# Disable mouse acceleration and set key repeat rate
xinput set-prop 9 'libinput Accel Profile Enabled' 0 1
xset r rate 300

# Disable screen automatically turning off
xset s off
xset s noblank
xset -dpms
