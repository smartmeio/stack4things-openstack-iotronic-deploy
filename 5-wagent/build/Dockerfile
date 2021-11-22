FROM ubuntu:bionic
#ENV VERSION=2.3.9

ENV DEBIAN_FRONTEND=noninteractive

ENV LC_CTYPE C.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LANG C.UTF-8
ENV LANG C.UTF-8

ARG user=iotronic
ARG group=iotronic
ARG uid=1000
ARG gid=1000
ARG IOTRONIC_HOME=/var/lib/iotronic

RUN apt-get update \
	&& apt-get install nocache -y software-properties-common locales tzdata\
	&& add-apt-repository -y cloud-archive:stein \
	&& apt-get update && apt-get -y dist-upgrade \
	&& apt-get install nocache -y build-essential python3-openstackclient \
		python3 python3-all python3-dev python3-all-dev python3-setuptools nano \
		vim curl iputils-ping wget git apache2 libapache2-mod-wsgi-py3 nginx \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& wget -qO- https://bootstrap.pypa.io/get-pip.py | python3 \
	&& :

RUN locale-gen en_US.UTF-8
ENV TZ 'Europe/Rome'
RUN echo $TZ > /etc/timezone && rm -f /etc/localtime && ln -nfs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Iotronic is run with user `iotronic`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN mkdir -p $IOTRONIC_HOME \
  && chown ${uid}:${gid} $IOTRONIC_HOME \
  && groupadd -g ${gid} ${group} \
  && useradd -d "$IOTRONIC_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user} \
  && echo iotronic:smartme | chpasswd \
  && echo root:smartme | chpasswd

# getting iotronic sudoer permissions
RUN echo "iotronic ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#RUN git clone https://opendev.org/x/iotronic.git /opt/build/iotronic
RUN git clone --depth 1 https://github.com/smartmeio/stack4things-openstack-iotronic.git /opt/build/iotronic

WORKDIR /opt/build/iotronic

RUN pip3 install -v --upgrade pip
RUN pip3 install -v --ignore-installed PyYAML
RUN pip3 install -v -r requirements.txt
RUN python3 setup.py install

#  RUN useradd -m -d /var/lib/iotronic iotronic

RUN mkdir -p /var/log/iotronic \
	&& mkdir /var/lib/wstun \
	&& touch /var/log/iotronic/iotronic-wagent.log \
	&& chown -R iotronic:iotronic /var/log/iotronic/

# RUN pip3 uninstall -y SQLAlchemy
# RUN pip3 install SQLAlchemy==1.3.20
RUN pip3 install -v SQLAlchemy

VOLUME ["/etc/iotronic"]
VOLUME ["/var/log/iotronic"]

RUN mkdir -p /etc/nginx/conf.d/iotronic \
	&& mkdir -p /etc/nginx/conf.d/iotronic/maps \
	&& mkdir -p /etc/nginx/conf.d/iotronic/servers \
	&& mkdir -p /etc/nginx/conf.d/iotronic/upstreams
COPY confs/mapping /etc/nginx/conf.d/iotronic/mapping
COPY conf/iotronic.conf /etc/iotronic/
COPY conf/allowlist /var/lib/wstun/

RUN echo "stream { include conf.d/iotronic/mapping; }" >> /etc/nginx/nginx.conf
RUN echo "include conf.d/iotronic/servers/*" >> /etc/nginx/sites-enabled/default


EXPOSE 443
EXPOSE 80

COPY bin/startWagent /usr/local/bin/startWagent

RUN chmod +x /usr/local/bin/startWagent

CMD ["/usr/local/bin/startWagent"]
#CMD ["/usr/local/bin/iotronic-wamp-agent"]