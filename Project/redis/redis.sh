#!/bin/bash

id=$(id -u)
date=$(date | awk -F " " '{print $3$1$6"_"$4}')
path="/tmp/$0_$date.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate() {
    if [ $1 -ne 0 ]; then
        echo -e " $2 ....is $R FAIED $N"
        exit 1
    else
        echo -e " $2 ... is $G Completed $N"
    fi
}

if [ $id -ne 0 ]; then
    echo -e "Error: please login with $R sudo  $N user"
    exit 1
fi

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$path
validate $? "installation is "

dnf module enable redis:remi-6.2 -y &>>$path
validate $? "modile enable  is "

dnf install redis -y &>>$path
validate $? "redis Instalaltion is "

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf &>>$path
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf &>>$path
validate $? "Ip change is "
systemctl enable redis
systemctl start redis
netstat -lntp | head -n 3
systemctl status redis | grep Active
