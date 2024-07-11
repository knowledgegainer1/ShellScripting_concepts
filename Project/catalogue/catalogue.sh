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

dnf module disable nodejs -y &>> $folder_path
validate $? "Disabled"
dnf module enable nodejs:18 -y &>> $folder_path
validate $? "Enabled 18 version"

dnf install nodejs -y  &>> $folder_path
validate $? "installing nodejs"

id roboshop
if [ $? -ne 0 ]
then
 useradd roboshop
 validate $? "creating roboshop  user"
else
 echo -e "User already created to $Y SKIPPING $N"
fi


mkdir -p /app
rm -rf /tmp/catalogue.zip 
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip
cd /app
unzip -o /tmp/catalogue.zip  &>> $folder_path
npm install &>> $folder_path
validate $? "dependencied Installation"
cp catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload


systemctl enable catalogue
systemctl start catalogue &>> $folder_path
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $folder_path
validate $? "mongorepo copied"
dnf install mongodb-org-shell -y &>> $folder_path
validate $? "mongo client Installation"
mongo --host 172.31.37.139 </app/schema/catalogue.js &>> $folder_path
validate $? "schema loaded "