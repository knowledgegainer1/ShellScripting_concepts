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



dnf install nginx -y &>> $folder_path
validate $? "nginx Instalation"

systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*  &>> $folder_path
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip  &>> $folder_path
cd /usr/share/nginx/html  
unzip -o /tmp/web.zip
cp /home/centos/ShellScripting_concepts/Project/web/web.sh /etc/nginx/default.d/roboshop.conf  &>> $folder_path
systemctl restart nginx 