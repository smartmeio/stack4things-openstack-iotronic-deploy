FROM rabbitmq:3.9.8

ENV RABBIT_PASS smartme

COPY scripts/rabbitmq-setup.sh /usr/local/bin/rabbitmq-setup

RUN chmod +x /usr/local/bin/rabbitmq-setup