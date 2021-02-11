FROM babim/ubuntubase:20.04
ENV DEBIAN_FRONTEND noninteractive
ENV KERIO_CONNECT_NOT_RUN yes

## Install ##
RUN apt-get update && apt-get install -y wget cryptsetup dnsutils sysstat lsof krb5-kdc krb5-admin-server
RUN wget -O kerio-connect-linux-64bit.deb http://media.matmagoc.com/kerio-connect-linux-64bit.deb && \
    dpkg -i kerio-connect-linux-64bit.deb || true && apt-get install -f && \
    mv /etc/krb5.conf /opt/kerio/krb5.conf && ln -sf /opt/kerio/krb5.conf /etc/krb5.conf

## Set service ##
RUN dpkg --fsys-tarfile kerio-connect-linux-64bit.deb | tar xOf - ./etc/init.d/kerio-connect > /etc/init.d/kerio-connect && \
    chmod +x /etc/init.d/kerio-connect && rm -f kerio-connect-linux-64bit.deb

## Clean ##
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

## Prepare start ##
#RUN mkdir -p /opt-start/kerio && rsync -arvpz --numeric-ids /opt/kerio/ /opt-start/kerio && rm -rf /opt/kerio/*
RUN mkdir /opt-start && mv /opt/kerio /opt-start

# Expose the default portonly 4040 is nessecary for admin access 
EXPOSE 4040 25 465 587 110 995 143 993 119 563 389 636 80 443 5222 5223 5269 44337

VOLUME ["/opt/kerio"]

ADD start.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
