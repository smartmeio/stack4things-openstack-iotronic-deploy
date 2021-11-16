#!/bin/bash -x

HOST="demo-controller.smartme.io"
HTTPS=true
ADMIN_PASS="smartme"

URL="http://$HOST:5001/v3"
if [ "$HTTPS" = true ] ; then
    URL="https://$HOST:5001/v3"
fi

echo $URL

keystone-manage db_sync
echo "db_sync"

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
echo "fernet_setup"

keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
echo "credential_setup"

keystone-manage bootstrap --bootstrap-password ${ADMIN_PASS} --bootstrap-admin-url ${URL} \
	--bootstrap-internal-url ${URL} --bootstrap-public-url ${URL} --bootstrap-region-id RegionOne
echo "boostrap"

openstack project create --domain default  --description "Service Project" service
echo "project_created"

chown -R keystone:keystone /var/log/keystone/
echo "permissions_to_var_log_keystone"

echo "restart the container"