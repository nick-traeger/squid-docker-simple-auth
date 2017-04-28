FROM alpine:3.5
MAINTAINER Evan Sarmiento <evansarm@gmail.com>
RUN apk update \
    && apk add squid=3.5.23-r0 \
    && apk add curl \
    && rm -rf /var/cache/apk/*
RUN mkdir /usr/etc
RUN mkdir /var/spool/squid3
RUN mkdir /var/spool/squid
RUN /usr/lib/squid/ssl_crtd -c -s /var/lib/ssl_db
COPY squid.conf /etc/squid/squid.conf
COPY transparent-cert.pem /etc/squid/ssl_cert/transparent-cert.pem
COPY transparent-key.pem /etc/squid/ssl_cert/transparent-key.pem
EXPOSE 3128
EXPOSE 3129
VOLUME /var/log/squid
ADD init /init
CMD ["/init"]
