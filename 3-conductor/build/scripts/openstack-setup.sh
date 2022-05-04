#! /bin/bash -x

IP_IOTRONIC="demo-controller.smartme.io"
HTTPS=true
IOTRONIC_PASS="smartme"

URL="http://$IP_IOTRONIC:8812"
if [ "$HTTPS" = true ] ; then
    URL="https://$IP_IOTRONIC:8812"
fi

echo ${URL}

if [ ! -e ${HOME}/.os_setup_completed ]
then
	openstack service create iot --name Iotronic
	openstack user create --password ${IOTRONIC_PASS} iotronic
	openstack role add --project service --user iotronic admin
	openstack role create admin_iot_project
	openstack role create manager_iot_project
	openstack role create user_iot
	openstack role add --project service --user iotronic admin_iot_project

	openstack endpoint create --region RegionOne iot public ${URL}
	openstack endpoint create --region RegionOne iot internal ${URL}
	openstack endpoint create --region RegionOne iot admin ${URL}

	openstack role add --project admin --user admin admin_iot_project

	apachectl -k graceful

	touch ${HOME}/.os_setup_completed
else
	echo "no need to setup openstack !"
fi
