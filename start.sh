#!/bin/bash

# Prepare Kerio bin
if [ -z "`ls /opt/kerio --hide='lost+found'`" ]
then
	cp -R /opt-start/kerio/* /opt/kerio
fi
if [ ! -f "/opt/kerio/mailserver/mailserver" ] && [ ! -f "/opt/kerio/mailserver/sendmail" ] && [ ! -f "/opt/kerio/mailserver/kmsrecover" ]
then
	cp -Rn /opt-start/kerio/* /opt/kerio/
fi

# Prepare DNS
if [ -f "/opt/kerio/mailserver/mailserver" ]; then
export HOSTNAME=$(hostname -s)
export DOMAIN=$(hostname -d)
export CONTAINERIP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
export DNSSERVER=${DNSSERVER:-8.8.8.8}
# Set DNS Server to localhost
echo "nameserver $DNSSERVER" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# ssh
    if [ -f "/runssh.sh" ]; then /runssh.sh; fi

# Start
function terminate {
	service kerio-connect stop
	exit 0
}
trap terminate TERM INT
service kerio-connect start
while :; do
	sleep 1;
done
else

echo "Install Wrong! Please Check Image or Path Config!"
echo "contact: babim@matmagoc.com"
sleep 60
fi
