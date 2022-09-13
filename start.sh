#!/bin/bash
echo "lets go and send connection info to influx"
sh /usr/src/app//sendips.sh

sleep 0.5
tee /usr/src/app//nohup.out > /proc/1/fd/1 2>/proc/1/fd/2
