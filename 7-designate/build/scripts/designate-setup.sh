IP_DESIGNATE="demo-controller.smartme.io"
HTTPS=true
DESIGNATE_PASS="smartme"

URL="http://$IP_DESIGNATE:9001"
if [ "$HTTPS" = true ] ; then
    URL="https://$IP_DESIGNATE:9001"
fi

echo $URL

if [ ! -e ${HOME}/.designate_setup_completed ]
then
  openstack service create dns --name Designate
  openstack user create --password $DESIGNATE_PASS designate
  openstack role add --project service --user designate admin

  openstack endpoint create --region RegionOne dns public $URL
  /bin/sh -c "designate-manage pool update" designate

  touch ${HOME}/.designate_setup_completed
else
	echo "no need to setup designate !"
fi
