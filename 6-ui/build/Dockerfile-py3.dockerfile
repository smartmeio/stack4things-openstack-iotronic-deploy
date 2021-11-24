FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANG C.UTF-8

RUN : \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y nocache \
		software-properties-common python3 python3-all apt-utils wget vim \
		python3-dev python3-all-dev python3-openstackclient nano apache2 \
		memcached python3-memcache openstack-dashboard git dialog curl gcc g++ \
	&& apt-get update && apt-get -y dist-upgrade \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& wget -qO- https://bootstrap.pypa.io/pip/get-pip.py | python3 \
	&& :

#RUN pip install setuptools

RUN git clone -b felooca_dev --depth 1 https://github.com/smartmeio/stack4things-openstack-iotronic-py-client.git /opt/build/python-iotronicclient
WORKDIR /opt/build/python-iotronicclient

RUN pip3 install -r requirements.txt
RUN python3 setup.py install

RUN git clone https://github.com/smartmeio/stack4things-openstack-iotronic-ui.git -b dev /opt/build/iotronic-ui
# COPY iotronic-ui/ /opt/build/iotronic-ui/

WORKDIR /opt/build/iotronic-ui

RUN pip3 install -r requirements.txt
RUN python3 setup.py install
RUN cp iotronic_ui/api/iotronic.py /usr/share/openstack-dashboard/openstack_dashboard/api/ \
#    && cp iotronic_ui/enabled/_60* /usr/share/openstack-dashboard/openstack_dashboard/enabled/
    && cp iotronic_ui/enabled/_6000_iot.py /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_61* /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_62* /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_63* /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_64* /usr/share/openstack-dashboard/openstack_dashboard/enabled/

RUN echo 'ServerName demo-controller' > /etc/apache2/conf-available/server-name.conf

RUN a2enconf server-name

#RUN apt-get remove --auto-remove openstack-dashboard-ubuntu-theme
COPY conf/local_settings.py /etc/openstack-dashboard/

COPY bin/startUI /usr/local/bin/startUI

RUN chmod +x /usr/local/bin/startUI

VOLUME ["/etc/openstack-dashboard/"]

EXPOSE 80
CMD ["/usr/local/bin/startUI"]
