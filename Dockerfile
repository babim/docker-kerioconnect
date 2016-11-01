FROM babim/ubuntubaseinit:14.04.ssh
ENV DEBIAN_FRONTEND noninteractive

## Install ##
RUN apt-get update && apt-get install -y wget bind9 bind9utils bind9-doc dnsutils resolvconf sysstat lsof rsync
RUN wget -O kerio-connect-linux-64bit.deb http://download.kerio.com/dwn/kerio-connect-linux-64bit.deb && \
    dpkg -i kerio-connect-linux-64bit.deb && apt-get install -f && rm -f kerio-connect-linux-64bit.deb

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
EXPOSE 4040 25 465 587 110 995 143 993 119 563 389 636 80 443 5222 5223

COPY etc /etc/

VOLUME ["/opt/kerio"]

ADD start.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh
