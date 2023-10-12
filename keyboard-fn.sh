#!/bin/sh

# Nuphy Keyboard Function Keys Switching
fnMode=`cat /sys/module/hid_apple/parameters/fnmode`

if [ $fnMode -eq 0 ]; then
  echo 3 | sudo tee /sys/module/hid_apple/parameters/fnmode 1>/dev/null
  echo "Disabled FN keys"
else
  echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode 1>/dev/null
  echo "Enabled FN keys"
fi  
