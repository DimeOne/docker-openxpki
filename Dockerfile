FROM debian:jessie

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV S6_OVERLAY_VERSION v1.11.0.1

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget && \
    wget http://packages.openxpki.org/debian/Release.key -O - | apt-key add - && \
    echo "deb http://packages.openxpki.org/debian/ jessie release" > /etc/apt/sources.list.d/openxpki.list && \
    echo "deb http://httpredir.debian.org/debian jessie non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      libdbd-mysql-perl \
      libapache2-mod-fcgid \
      libopenxpki-perl \
      openxpki-i18n \
      openca-tools \
      mysql-client && \
    a2enmod fcgid && \
    wget -q -O - https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xzf - -C / && \
    apt-get remove -y wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD scripts/docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

COPY configs/services.d/apache2 /etc/services.d/apache2
COPY configs/services.d/openxpki /etc/services.d/openxpki
COPY configs/fix-attrs.d /etc/fix-attrs.d/

ENTRYPOINT ["/docker-entrypoint.sh"]