#!/bin/sh
if [ "$(playerctl status 2>/dev/null)" != "" ]
then
  exec playerctl metadata --format '{{trunc(title,25)}} - {{artist}}'
else
  echo "Offline"
fi
