FROM ubuntu:bionic
#ENV VERSION=2.3.9

RUN apt-get update \
 && apt-get install nocache -y software-properties-common \
 && add-apt-repository -y cloud-archive:stein \
 && apt-get update && apt-get -y dist-upgrade && apt-get install nocache -y python3-openstackclient nano iputils-ping net-tools

RUN apt-get install nocache keystone -y

RUN mkdir -p /var/log/keystone \
&& touch /var/log/keystone/keystone-manage.log \
&& touch /var/log/keystone/keystone-wsgi-public.log \
&& touch /var/log/keystone/keystone.log \
&& chown -R keystone:keystone /var/log/keystone/ 

VOLUME ["/etc/keystone"]
VOLUME ["/var/log/keystone"]

EXPOSE 5000
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
