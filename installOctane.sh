#!/bin/bash

curl -O https://raw.githubusercontent.com/panama69/HPE-ALM-Octane-Docker/master/remove_nga_folders.sh
chmod 777 ./remove_nga_folders.sh
./remove_nga_folders.sh
rm -f ./remove_nga_folders.sh

curl -O https://raw.githubusercontent.com/panama69/HPE-ALM-Octane-Docker/master/deployNga.sh

chmod 777 deployNga.sh

./deployNga.sh hpe.software Password1

rm -rf ./deployNga.sh

echo "**********************************************"
echo "**********************************************"
echo "********                              ********"
echo "********     Almost Done, 30s more    ********"
echo "********                              ********"
echo "**********************************************"
echo "**********************************************"
sleep 30s

/usr/bin/firefox -new-window http://localhost:8085/ui
