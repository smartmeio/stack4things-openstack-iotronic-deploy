FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANG C.UTF-8

RUN : \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y nocache \
			software-properties-common python python-all apt-utils  \
			python-dev python-all-dev python-openstackclient nano apache2 \
		memcached python-memcache openstack-dashboard git dialog curl wget vim \
	&& apt-get update && apt-get -y dist-upgrade \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& wget -qO- https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2 \
	&& :

#RUN pip install setuptools

RUN git clone -b felooca_dev --depth 1 https://github.com/smartmeio/stack4things-openstack-iotronic-py-client.git /opt/build/python-iotronicclient
WORKDIR /opt/build/python-iotronicclient

RUN pip2 install -r requirements.txt
RUN python2 setup.py install

RUN git clone https://github.com/smartmeio/stack4things-openstack-iotronic-ui.git -b dev /opt/build/iotronic-ui
# COPY iotronic-ui/ /opt/build/iotronic-ui/

WORKDIR /opt/build/iotronic-ui

RUN pip install -r requirements.txt
RUN python setup.py install
RUN cp iotronic_ui/api/iotronic.py /usr/share/openstack-dashboard/openstack_dashboard/api/ \
#    && cp iotronic_ui/enabled/_60* /usr/share/openstack-dashboard/openstack_dashboard/enabled/
    && cp iotronic_ui/enabled/_6000_iot.py /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_61* /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_62* /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_63* /usr/share/openstack-dashboard/openstack_dashboard/enabled/ \
    && cp iotronic_ui/enabled/_64* /usr/share/openstack-dashboard/openstack_dashboard/enabled/

#RUN apt-get remove --auto-remove openstack-dashboard-ubuntu-theme
COPY conf/local_settings.py /etc/openstack-dashboard/

COPY bin/startUI /usr/local/bin/startUI

RUN chmod +x /usr/local/bin/startUI

VOLUME ["/etc/openstack-dashboard/"]

EXPOSE 80
CMD ["/usr/local/bin/startUI"]
