#1/bin/bash

id=$(id -u)
date=$(date +%F-%T)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
folder_path="/tmp/$0_$date.log"
validate (){
    if [ $1 -ne 0 ]
    then
     echo -e "$2 ....$R FAILED $N"
    else
     echo  -e "$2 ...$G Success $N"
    fi
}
if [ $id -ne 0 ]
then
 echo "Error: please login with sudo user and try"
 exit 1
fi
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $folder_path
validate $? "Copy to mongo repo"

systemctl enable mongod &>> $folder_path
systemctl start mongod &>> $folder_path


sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $folder_path
validate $? "renamed"
systemctl restart mongod

dnf install mongodb-org -y 
validate $? "mongoDB Installation.."

echo "netstat -lntp | grep 27017 | cut -d " " -f4 "  &>> 