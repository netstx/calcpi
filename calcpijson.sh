#!/bin/bash
N=`cat /proc/cpuinfo | grep processor | wc -l`

# Calculating the first 5000 decimals of pi using $N parallel processes
TimeBegin=`date +%s.%N`
for ((i=1; i<=$N; i++))
do
        echo "scale=5000; 4*a(1)" | bc -l -q > /dev/null &
done
wait
TimeEnd=`date +%s.%N`

# Calculate results
## Total time: $DT seconds
DT=`echo "scale=2; ($TimeEnd - $TimeBegin) / 1" | bc`
## Average time per calculation: $DTc seconds
DTc=`echo "scale=2; ($TimeEnd - $TimeBegin) / $N" | bc`

# RFC3339 timestamp
timestamp=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

# Get hostname
hostname=`hostname`

# Get uptime
if [ -f "/proc/uptime" ]; then
uptime=`cat /proc/uptime`
uptime=${uptime%%.*}
else
uptime=""
fi

# Print results in ugly JSON format
printf '{"type":"calcpi","host":"%s","timestamp":"%s","calcpi":%s,"uptime":%s}\n' "$hostname" "$timestamp" "$DTc" "$uptime"
