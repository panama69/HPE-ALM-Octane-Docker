#!/bin/bash

# need to add the log folder mappings
#docker run -d -p 8080:8080 -e "SERVER_DOMAIN=flynn.net" -e "ADMIN_PASSWORD=HPALMdem0s"  -v /opt/octane/repo:/opt/octane/repo --net nga_nw --name nga --restart=always flynn/octane
docker run -it -p 8080:8080 -e "SERVER_DOMAIN=flynn.net" -e "ADMIN_PASSWORD=HPALMdem0s"  -v /opt/octane/repo:/opt/octane/repo -v /opt/octane/log:/opt/octane/log --net nga_nw --name nga --restart=always flynn/octane /bin/bash
