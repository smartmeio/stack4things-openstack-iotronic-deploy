FROM node:dubnium-alpine
ENV VERSION=allowlist
#1.1.0

ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANG C.UTF-8

#RUN npm install -g --unsafe @mdslab/wstun \
# && npm cache --force clean

RUN apk --no-cache add git

RUN npm install -g --unsafe websocket@1.0.26 optimist@0.6.1 node-uuid@1.4.7 under_score log4js@1.1.1 && npm cache --force clean

RUN git clone -b $VERSION --depth 1 https://github.com/MDSLab/wstun.git /usr/local/lib/node_modules/@mdslab/wstun/

#COPY wstun /usr/local/lib/node_modules/@mdslab/wstun

ENV NODE_PATH=/usr/local/lib/node_modules

WORKDIR /usr/bin/

#EXPOSE 40001-40050
EXPOSE 8080

RUN mkdir -p /var/log/wstun/

#RUN mkdir -p /var/lib/iotronic/ssl/
#COPY ./confs/ssl/ /var/lib/iotronic/ssl/
#COPY ./confs/allowlist /var/lib/wstun/


#ENTRYPOINT ["node", "/usr/local/lib/node_modules/@mdslab/wstun/bin/wstun.js", "-r", "-s", "8080", "--ssl=false", "-a/var/lib/iotronic/wstun/allowlist"]
ENTRYPOINT ["node", "/usr/local/lib/node_modules/@mdslab/wstun/bin/wstun.js", "-r", "-s", "8080", "--ssl=true", "--key=/var/lib/iotronic/ssl/iotronic.key", "--cert=/var/lib/iotronic/ssl/iotronic.pem", "-a/var/lib/wstun/allowlist"]
