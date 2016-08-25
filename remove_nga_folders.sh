echo "stopping containers"
docker stop nga nga_es nga_oracle
echo "removing containers"
docker rm nga nga_es nga_oracle
echo "removing images"
docker rmi alexeiled/docker-oracle-xe-11g elasticsearch:2.2 hpsoftware/nga 
rm -rf /etc/nga
rm -rf /var/log/nga
rm -rf /var/nga
