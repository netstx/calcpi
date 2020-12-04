#!/bin/bash
N=`cat /proc/cpuinfo | grep processor | wc -l`

cat /proc/cpuinfo | grep "model name"
echo
echo "Calculating the first 5000 decimals of pi using $N parallel processes"
TimeBegin=`date +%s.%N`

for ((i=1; i<=$N; i++))
do
        echo "scale=5000; 4*a(1)" | bc -l -q > /dev/null &
done
wait

TimeEnd=`date +%s.%N`
DT=`echo "scale=2; ($TimeEnd - $TimeBegin) / 1" | bc`
echo "Total time: $DT seconds"
DTc=`echo "scale=2; ($TimeEnd - $TimeBegin) / $N" | bc`
echo "Average time per calculation: $DTc seconds"
