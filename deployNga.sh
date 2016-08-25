#!/bin/sh

if [[ $# -lt 2 ]] ; then
    echo 'usage:  ./install_nga.sh <domain name used for this installation> <default password>'
    exit 1
fi

domain=$1
password=$2

echo "domain $domain"

# create a docker network to let the container communicate
echo "Create the demo-net network"
x=$(docker network ls|grep -c -w "demo-net")
if [ $x -ge 1 ]; then 
    echo "demo-net already exists"
else
    docker network create --ip-range=172.50.1.0/24 --subnet=172.50.0.0/16 demo-net
fi

# create oracle database container
docker run -d  -p 9090:8080/tcp -p 1521:1521/tcp -v /usr/lib/oracle/xe/oradata/XE:/usr/lib/oracle/xe/oradata/XE --shm-size=2g --net demo-net --ip=172.50.1.2 --restart=always --name nga_oracle alexeiled/docker-oracle-xe-11g
#docker run -d -v /usr/lib/oracle/xe/oradata/XE:/usr/lib/oracle/xe/oradata/XE --shm-size=2g --net demo-net --ip=172.50.1.2 --restart=always --name nga_oracle alexeiled/docker-oracle-xe-11g

# create Elastic Search container
docker run -d -p 9200:9200/tcp -p 9300:9300/tcp -e "ES_HEAP_SIZE=4G" -v /var/elasticsearch/data:/usr/share/elasticsearch/data --net demo-net --ip=172.50.1.3 --name nga_es --restart=always elasticsearch:2.2
#docker run -d -e "ES_HEAP_SIZE=4G" -v /var/elasticsearch/data:/usr/share/elasticsearch/data --net demo-net --ip=172.50.1.3 --name nga_es --restart=always elasticsearch:2.2

# install NGA
docker run -d -p 8085:8080 -p 8445:8443 -e "SERVER_DOMAIN=$domain" -e "ADMIN_PASSWORD=$password" -v /etc/nga:/etc/nga -v /var/log/nga/:/var/log/nga -v /var/nga/repo:/var/nga/repo --net demo-net --ip=172.50.1.1 --name nga --restart=always hpsoftware/nga
#docker run -d -p 8085:8080 -e "SERVER_DOMAIN=$domain" -e "ADMIN_PASSWORD=$password" -v /etc/nga:/etc/nga -v /var/log/nga/:/var/log/nga -v /var/nga/repo:/var/nga/repo --net demo-net --ip=172.50.1.1 --name nga --restart=always hpsoftware/nga

# wait for everything to settle down
sleep 1m

# print docker output
docker logs nga

# print wrapper log
tail -n 200 /var/log/nga/wrapper.log
