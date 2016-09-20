#FROM oraclelinux:latest
FROM centos:latest

MAINTAINER Dave Flynn <flynn@hpe.com>

RUN yum -y install java-1.8.0-openjdk-devel && rm -rf /var/cache/yum/*

#flynn
# tar - needed to extract the setup tool
# sudo - needed by the setup
# which - used by the setup to find which java is available
# initscripts - used by set up for 'service HPALM start'
RUN yum -y update && yum -y install tar && yum -y install sudo && yum -y install which && yum -y install initscripts && rm -rf /var/cache/yum/*
COPY ./ALM_Octane_Linux_RPM_octane-onprem-12.53.8.2116.rpm /tmp/ALM_Octane_Linux_RPM_octane-onprem-12.53.8.2116.rpm
COPY ./Octane_setup_tool.tar.gz /tmp/Octane_setup_tool.tar.gz
RUN mkdir /tmp/setups
COPY ./setups/setup.xml /tmp/setups
COPY ./setups/hazelcast.xml /tmp/setups

RUN cd /tmp && tar -zxvf Octane_setup_tool.tar.gz

EXPOSE 8080

ENV JAVA_HOME /usr/lib/jvm/java-openjdk

CMD ["java", "-version"]
