#!/bin/bash

cpu_load=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs)
mem_free=$(free -m | awk '/Mem:/ { print $7 }')
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "--- SERVER HEALTH REPORT ---"
echo "CPU Load (1m): $cpu_load"
echo "Memory Avail: ${mem_free}MB"
echo "Disk Usage:   ${disk_usage}%"

if [ $mem_free -le 20 ]
then
	echo "$(date) Low Memory!" >> memory.log
else 
	echo "$(date) Memory under limit" >> memory.log
fi

