#!/bin/sh

# disable system bell and X screensaver
# note: blank the screen with `xset s activate`
xset b off
xset s off

# turn on numlock
numlockx

# start the hotkey daemon and disable touchpad while typing
sxhkd &
syndaemon -i 1 &
synclient TapButton1=1 TapButton2=3 TapButton3=2

# set the wallpaper and start the compositor
$HOME/.fehbg &
compton -b

pulseaudio --start

# set the status for dwm
while true ; do
  xsetroot -name "$($HOME/bin/dwm-status)"
  sleep 1s
done &

# replace this process with dwm
exec /usr/bin/dwm-start
