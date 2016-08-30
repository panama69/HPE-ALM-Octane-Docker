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
COUNTER=0
echo -n "Still starting "
while [ $COUNTER -lt 10 ]; do
     let found=`grep "Server is ready!" /var/log/nga/wrapper.log|wc -l`
     if [ $found -lt  1 ]; then 
          echo -n "." 
          if [ $COUNTER -eq 10 ]; then
               echo
               echo "Something unusual has happend.  Check /var/log/nga/wrapper.log for possible errors"
          fi
     else
          echo
          echo "Up and ready for use"
          /usr/bin/firefox -new-window http://localhost:8085/ui
          let COUNTER=10
     fi
     let COUNTER+=1
     sleep 10 
done
