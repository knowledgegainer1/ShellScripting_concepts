#1/bin/bash

id=$(id -u)
date=$(date +%F-%T)
folder_path="/tmp/$0_$date.log"

echo "details saved to $folder_path"