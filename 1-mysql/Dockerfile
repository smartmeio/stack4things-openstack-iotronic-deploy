FROM mariadb:10.7.1-focal

COPY initfile.sql /docker-entrypoint-initdb.d/initfile.sql
COPY 99-openstack.conf /etc/mysql/mariadb.conf.d/99-openstack.conf