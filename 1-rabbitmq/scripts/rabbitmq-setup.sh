#! /bin/bash


#if [ "$EUID" -ne 0 ]
#  then echo "Please run as root"
#  exit
#cfi

RABBIT_PASS="smartme"

rabbitmqctl add_user openstack $RABBIT_PASS
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

echo -e "\e[32mCompleted \e[0m"