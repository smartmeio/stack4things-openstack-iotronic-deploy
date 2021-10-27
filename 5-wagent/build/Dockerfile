FROM ubuntu:bionic
#ENV VERSION=2.3.9

ENV DEBIAN_FRONTEND=noninteractive

ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANG C.UTF-8

RUN apt-get update \
 && apt-get install nocache -y software-properties-common locales tzdata\
 && add-apt-repository -y cloud-archive:stein \
 && apt-get update && apt-get -y dist-upgrade && apt-get install nocache -y build-essential python3-openstackclient python3 python3-setuptools python3-pip vim curl iputils-ping

RUN locale-gen en_US.UTF-8
ENV TZ 'Europe/Rome'
RUN echo $TZ > /etc/timezone && rm -f /etc/localtime && ln -nfs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install nocache -y git apache2 python3-setuptools libapache2-mod-wsgi-py3
#RUN git clone https://opendev.org/x/iotronic.git /opt/build/iotronic
#RUN git clone -b felooca_dev --depth 1 ssh://git@git.smartme.io:20022/smartme.io/stack4things/iotronic/iotronic.git /opt/build/iotronic
COPY ./iotronic /opt/build/iotronic

WORKDIR /opt/build/iotronic

RUN pip3 install --upgrade pip
RUN pip3 install --ignore-installed PyYAML
RUN pip3 install -r requirements.txt 
RUN python3 setup.py install
RUN useradd -m -d /var/lib/iotronic iotronic
RUN mkdir -p /var/log/iotronic \
&& touch /var/log/iotronic/iotronic-wagent.log \
&& chown -R iotronic:iotronic /var/log/iotronic/ 

RUN pip3 uninstall -y SQLAlchemy
RUN pip3 install SQLAlchemy==1.3.20

VOLUME ["/etc/iotronic"]
VOLUME ["/var/log/iotronic"]

RUN mkdir -p /etc/nginx/conf.d/iotronic \
&& mkdir -p /etc/nginx/conf.d/iotronic/maps \
&& mkdir -p /etc/nginx/conf.d/iotronic/servers \
&& mkdir -p /etc/nginx/conf.d/iotronic/upstreams
COPY confs/mapping /etc/nginx/conf.d/iotronic/mapping

RUN echo "stream { include conf.d/iotronic/mapping; }" > /etc/nginx/nginx.conf
RUN echo "include conf.d/iotronic/servers/*" > /etc/nginx/sites-enabled/default


EXPOSE 443
EXPOSE 80

COPY bin/startWagent /usr/local/bin/startWagent

CMD ["/usr/local/bin/startWagent"]
#CMD ["/usr/local/bin/iotronic-wamp-agent"]