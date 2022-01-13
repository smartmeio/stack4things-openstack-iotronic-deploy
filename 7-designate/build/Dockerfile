FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

ENV LC_CTYPE C.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LANG C.UTF-8

RUN apt-get update \
 && apt-get install nocache -y software-properties-common locales tzdata\
 && add-apt-repository -y cloud-archive:xena \
 && apt-get update && apt-get -y dist-upgrade \
 && apt-get install nocache -y build-essential python3-openstackclient \
   python3 python3-all python3-setuptools nano vim wget curl \
   nocache bind9 bind9utils bind9-doc designate-worker designate-producer designate-mdns \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && wget -qO- https://bootstrap.pypa.io/get-pip.py | python3 \
 && :

RUN locale-gen en_US.UTF-8
ENV TZ 'Europe/Rome'
RUN echo $TZ > /etc/timezone && rm -f /etc/localtime && ln -nfs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

#RUN rndc-confgen -a -k designate -c /etc/bind/rndc.key -r /dev/urandom

COPY conf/adminrc /root/

COPY conf/designate.conf /etc/designate/
COPY conf/pools.yaml /etc/designate/
COPY conf/named.conf.options  /etc/bind/

COPY bin/startDesignate /usr/local/bin/startDesignate
COPY scripts/designate-setup.sh /usr/local/bin/designate-setup

RUN chown -R designate:designate /var/log/designate/

RUN chmod +x /usr/local/bin/startDesignate
RUN chmod +x /usr/local/bin/designate-setup

VOLUME ["/etc/designate"]
VOLUME ["/etc/bind"]
VOLUME ["/var/log/designate"]

EXPOSE 9001
EXPOSE 53
EXPOSE 53/udp

CMD ["/usr/local/bin/startDesignate"]
