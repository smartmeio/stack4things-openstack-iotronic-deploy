FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANG C.UTF-8

RUN apt-get update \
 && apt-get install nocache -y software-properties-common locales tzdata\
 && add-apt-repository -y cloud-archive:xena \
 && apt-get update && apt-get -y dist-upgrade && apt-get install nocache -y build-essential python3-openstackclient python3 python3-setuptools python3-pip vim

RUN locale-gen en_US.UTF-8
ENV TZ 'Europe/Rome'
RUN echo $TZ > /etc/timezone && rm -f /etc/localtime && ln -nfs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install nocache bind9 bind9utils bind9-doc designate-worker designate-producer designate-mdns -y
#RUN rndc-confgen -a -k designate -c /etc/bind/rndc.key -r /dev/urandom

COPY bin/startDesignate /usr/local/bin/startDesignate

VOLUME ["/etc/designate"]
VOLUME ["/etc/bind"]
VOLUME ["/var/log/designate"]

EXPOSE 9001
EXPOSE 53
EXPOSE 53/udp

CMD ["/usr/local/bin/startDesignate"]
