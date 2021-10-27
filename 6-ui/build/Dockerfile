FROM ubuntu:bionic


RUN apt-get update \
 && apt-get install nocache -y software-properties-common \
 #&& add-apt-repository -y cloud-archive:stein \
 #&& add-apt-repository -y cloud-archive:queens \
 && apt-get update && apt-get -y dist-upgrade && apt-get install nocache -y python-openstackclient nano

RUN apt-get install nocache memcached python-memcache openstack-dashboard git python-pip -y

#RUN pip install setuptools

RUN git clone https://opendev.org/x/python-iotronicclient.git /opt/build/python-iotronicclient
WORKDIR /opt/build/python-iotronicclient

RUN pip install -r requirements.txt 
RUN python setup.py install

#RUN git clone https://opendev.org/x/iotronic-ui.git /opt/build/iotronic-ui
COPY iotronic-ui/ /opt/build/iotronic-ui/

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

COPY bin/startUI /usr/local/bin/startUI

VOLUME ["/etc/openstack-dashboard/"]

EXPOSE 80
CMD ["/usr/local/bin/startUI"]
