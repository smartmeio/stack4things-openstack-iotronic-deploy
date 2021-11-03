FROM ubuntu:focal
#ENV VERSION=2.3.9

ENV DEBIAN_FRONTEND=noninteractive

ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANG C.UTF-8


RUN : \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y nocache \
 		software-properties-common locales tzdata build-essential \
		python3-openstackclient python3 python3-setuptools vim \
		python3-all python3-dev python3-all-dev \
 	&& add-apt-repository -y cloud-archive:wallaby \
 	&& apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& wget -qO- https://bootstrap.pypa.io/pip/get-pip.py | python3 \
	&& :

RUN locale-gen en_US.UTF-8
ENV TZ 'Europe/Rome'
RUN echo $TZ > /etc/timezone && rm -f /etc/localtime && ln -nfs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install nocache -y git apache2 python3-setuptools libapache2-mod-wsgi-py3
RUN git clone -b felooca_dev --depth 1 https://github.com/smartmeio/stack4things-openstack-iotronic.git /opt/build/iotronic
#RUN git clone -b felooca_dev --depth 1 ssh://git@git.smartme.io:20022/smartme.io/stack4things/iotronic/iotronic.git /opt/build/iotronic
#COPY ./iotronic /opt/build/iotronic

WORKDIR /opt/build/iotronic

RUN pip3 install --upgrade pip
RUN pip3 install --ignore-installed PyYAML
RUN pip3 install -r requirements.txt
RUN python3 setup.py install
RUN useradd -m -d /var/lib/iotronic iotronic
RUN mkdir -p /var/log/iotronic \
	&& touch /var/log/iotronic/iotronic-conductor.log \
	&& touch /var/log/iotronic/iotronic-api_error.log \
	&& touch /var/log/iotronic/iotronic-api_access.log \
	&& chown -R iotronic:iotronic /var/log/iotronic/ \
	&& cp etc/apache2/iotronic.conf /etc/apache2/sites-available/iotronic.conf

# RUN pip3 uninstall -y SQLAlchemy
# RUN pip3 install SQLAlchemy==1.3.20


RUN a2ensite iotronic

COPY conf/iotronic.conf /etc/iotronic/
COPY scripts/openstack-setup.sh /usr/local/bin/openstack-setup

RUN chmod +x /usr/local/bin/openstack-setup

COPY bin/startConductor /usr/local/bin/startConductor
VOLUME ["/etc/iotronic"]
VOLUME ["/var/log/iotronic"]

EXPOSE 8812

CMD ["/usr/local/bin/startConductor"]