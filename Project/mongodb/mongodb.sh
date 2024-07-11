#1/bin/bash

id=$(id -u)
date=$(date +%F-%T)
folder_path="/tmp/$0_$date.log"
if [ $id -ne 0 ]
then
 echo "Error: please login with sudo user and try"
 exit 1
fi
echo "details saved to $folder_path"