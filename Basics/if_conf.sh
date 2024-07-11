#!/bin/bash

x=$(id -u)

if [ $x -ne 0 ]
then
  echo "please access with sudo user"
  exit 1
else
  echo "u are sudo user"
fi

yum install nginx -y
