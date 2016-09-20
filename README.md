# HPE-ALM-Octane-Docker
Shell script to start ALM Octane using Docker

Assumptions: 
  1) You have a Docker (http://www.docker.com) environment (docker-engine).  If not, you will need to install on your Linux machine or VM.
  
  2) You have internet access.
  
  3) You have port 8080 available.  If not you will either need to make it available or change the shell script to use some thing else in the -p <myport>:8080
  

NOTE:
The 12.53.08 folder contains files to generate Octane 12.53.08 image.  It leverages an on prem installation tool which assists in configuring Octane which can be found https://hpln.hpe.com/contentoffering/hpe-alm-octane-on-prem-setup-tool.

This image uses the Elasticsearch and Oracl Express images that are used with the Octane 12.53.4
