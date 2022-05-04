#! /bin/bash


#if [ "$EUID" -ne 0 ]
#  then echo "Please run as root"
#  exit
#cfi

if [ ! -f ${HOME}/.rabbitmq_setup_completed ]
then
        RABBIT_PASS="smartme"

        rabbitmqctl add_user openstack $RABBIT_PASS
        rabbitmqctl set_permissions openstack ".*" ".*" ".*"

        touch ${HOME}/.rabbitmq_setup_completed

        echo -e "\e[32mCompleted \e[0m"
else
        echo "no need to setup rabbitmq !"
fi