#!/bin/sh

if [[ $# -lt 2 ]] ; then
    echo 'usage:  ./install_nga.sh <domain name used for this installation> <default password>'
    exit 1
fi

domain=$1
password=$2

echo "domain $domain"

# create a docker network to let the container communicate
docker network create nga_nw

# create oracle database container
docker run -d  -v /usr/lib/oracle/xe/oradata/XE:/usr/lib/oracle/xe/oradata/XE --shm-size=2g --net nga_nw  --restart=always --name nga_oracle alexeiled/docker-oracle-xe-11g

# create Elastic Search container
docker run -d  -e "ES_HEAP_SIZE=4G" -v /var/elasticsearch/data:/usr/share/elasticsearch/data  --net nga_nw  --name nga_es --restart=always elasticsearch:2.2

# install NGA
docker run -d -p 8080:8080 -e "SERVER_DOMAIN=$domain" -e "ADMIN_PASSWORD=$password"  -v /etc/nga:/etc/nga -v /var/log/nga/:/var/log/nga -v /var/nga/repo:/var/nga/repo --net nga_nw --name nga --restart=always hpsoftware/nga

# wait for everything to settle down
sleep 45s

# print docker output
docker logs nga

# print wrapper log
#tail -n 200 /var/log/nga/wrapper.log
tail -n 30 /var/log/nga/wrapper.log
