#!/bin/bash

images="elasticsearch:2.2|alexeiled/docker-oracle-xe-11g|hpsoftware/nga"
containers=$(docker ps -a|grep -E $images|awk '{print $1}')

echo "******************************"
echo "******************************"
echo "***  stopping containers"
echo "******************************"
echo "******************************"
if [ -n "${containers}" ]; then
     docker ps -a|grep -E $images|awk '{printf "%-20s %-12s %s\n",$NF,$1,$2}'
     for c in $containers; do
          docker stop $c >/dev/null
     done
else
     echo "No matching containers to stop"
fi

echo
echo
echo "******************************"
echo "******************************"
echo "***  removing containers"
echo "******************************"
echo "******************************"
if [ -n "${containers}" ]; then
     docker ps -a|grep -E $images|awk '{printf "%-20s %-12s %s\n",$NF,$1,$2}'
     for c in $containers; do
          docker rm $c >/dev/null
     done
else
     echo "No matching containers to remove"
fi

echo
echo
echo "******************************"
echo "******************************"
echo "***  removing images"
echo "******************************"
echo "******************************"
list=$(echo $images|tr "|" "\n")
for i in $list; do
     echo $i
     docker rmi $i >/dev/null
done

echo
echo
echo "******************************"
echo "******************************"
echo "***  removing mounted folders"
echo "******************************"
echo "******************************"
rm -rf /etc/nga
rm -rf /var/log/nga
rm -rf /var/nga
