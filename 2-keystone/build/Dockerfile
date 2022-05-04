FROM ubuntu:bionic
#ENV VERSION=2.3.9

RUN : \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y nocache software-properties-common \
		 python3-openstackclient nano iputils-ping net-tools keystone wget curl vim nano \
	&& add-apt-repository -y cloud-archive:stein \
	&& apt-get update && apt-get -y dist-upgrade \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& wget -qO- https://bootstrap.pypa.io/pip/get-pip.py | python3 \
	&& :

# RUN apt-get install nocache keystone -y

RUN mkdir -p /var/log/keystone \
  && touch /var/log/keystone/keystone-manage.log \
  && touch /var/log/keystone/keystone-wsgi-public.log \
  && touch /var/log/keystone/keystone.log \
  && chown -R keystone:keystone /var/log/keystone/

COPY scripts/keystone-setup.sh /usr/local/bin/keystone-setup

COPY conf/keystone.conf /etc/keystone/

RUN chmod +x /usr/local/bin/keystone-setup

RUN echo 'ServerName demo-controller' > /etc/apache2/conf-available/server-name.conf

RUN a2enconf server-name

VOLUME ["/etc/keystone"]
VOLUME ["/var/log/keystone"]

EXPOSE 5000
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
