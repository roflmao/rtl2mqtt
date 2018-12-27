#!/bin/bash

# A simple script that will receive events from a RTL433 SDR

# Author: Marco Verleun <marco@marcoach.nl>
# Version 2.0: Adapted for the new output format of rtl_433

# Remove hash on next line for debugging
#set -x

export LANG=C
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

#
# Start the listener and enter an endless loop
#
/usr/local/bin/rtl_433 -F json |  while read line
do
  echo $line

# Raw message to MQTT
  echo $line  | /usr/bin/mosquitto_pub -h $MQTT_HOST -i RTL_433 -l -t "RTL_433/Raw"
done
