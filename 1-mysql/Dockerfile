FROM mariadb:focal

COPY create_dbs.sql smartme_test_iotronic_db:/docker-entrypoint-initdb.d/create_dbs.sql
COPY 99-openstack.conf /etc/mysql/mariadb.conf.d/99-openstack.conf