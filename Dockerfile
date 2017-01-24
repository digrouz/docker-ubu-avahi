# vim:set ft=dockerfile:
FROM ubuntu:latest
MAINTAINER DI GREGORIO Nicolas "nicolas.digregorio@gmail.com"

### Environment variables
ENV DEBIAN_FRONTEND='noninteractive' \
    GOSU_VERSION='1.10'


### Install Applications DEBIAN_FRONTEND=noninteractive  --no-install-recommends
RUN apt-get update && \
    apt-get -y --no-install-recommends dist-upgrade && \
    apt-get install -y --no-install-recommends ca-certificates wget avahi-daemon dbus libnss-mdns  && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)"  && \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4  && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    apt-get -y autoclean && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    gosu nobody true && \
    rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/*

### Volume
VOLUME ["/var/run/dbus"]

### Expose ports
EXPOSE 5353

### Running User: not used, managed by docker-entrypoint.sh
#USER avahi

### Start avahi-daemon
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["avahi"]
