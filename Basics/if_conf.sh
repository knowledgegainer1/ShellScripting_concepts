#!/bin/bash

x=$(id -u)

if [ $x -ne 0]
then
  echo "please access with sudo user"
  y=$(echo $?)
  exit $y
else
  echo "u are sudo user"

