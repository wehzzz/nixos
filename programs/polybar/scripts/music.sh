#!/bin/sh
if [ "$(playerctl status 2>/dev/null)" = "Playing" ] || [ "$(playerctl status 2>/dev/null)" = "Paused" ]
then
  title=`exec playerctl metadata xesam:title`
  artist=`exec playerctl metadata xesam:artist`
  echo "$title - $artist"
else
  echo "Offline"
fi
