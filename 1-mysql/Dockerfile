FROM mariadb:focal

COPY initfile.sql /docker-entrypoint-initdb.d/initfile.sql
COPY 99-openstack.conf /etc/mysql/mariadb.conf.d/99-openstack.conf