#!/bin/bash

id=$(id -u)
date=$(date | awk -F " " '{print $3$1$6"_"$4}')
path="/tmp/$0_$date.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate (){
    if [ $1 -ne 0 ]
    then
     echo " $2 ....is $R FAIED $N"
    else
     echo " $2 ... is $R Completed $N"
    f1
}
if [ $id -ne 0 ]
then
 echo "Error:please login with $R sudo  $N user"
fi

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $path
validate $? "installation is "

dnf module enable redis:remi-6.2 -y  &>> $path

dnf install redis -y  &>> $path

sed -i 's/127.0.0.1/0.0.0.0/'  /etc/redis.conf   &>> $path
systemctl enable redis
systemctl start redis
netstat -lntp | head -n 3
systemctl status redis | grep Active 
