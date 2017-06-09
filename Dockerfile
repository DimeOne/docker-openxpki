FROM debian:jessie

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

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
      libapache2-mod-rpaf \
      libapache2-mod-fcgid \
      libopenxpki-perl \
      openxpki-i18n \
      openca-tools \
      mysql-client && \
    a2enmod fcgid && \
    a2enmod rpaf && \
    a2dismod status && \
    apt-get remove -y wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD configs/apache2/mods-enabled/rpaf.conf /etc/apache2/mods-enabled/rpaf.conf

ADD scripts/docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

VOLUME ["/etc/openxpki"]

ENTRYPOINT ["/docker-entrypoint.sh"]