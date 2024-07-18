#!/bin/sh

# We are running in a container
confgen_container=true

# If there's a combined pem we need to split it into a cert and key for syslog-ng
if [ -e /opt/syslog-ng/etc/cert.d/combined.pem ]; then
    openssl x509 -in /opt/syslog-ng/etc/cert.d/combined.pem -out /opt/syslog-ng/etc/cert.d/certificate.crt
    openssl storeutl -keys /opt/syslog-ng/etc/cert.d/combined.pem > /opt/syslog-ng/etc/cert.d/certificate.key
fi

# Start syslog-ng
/opt/syslog-ng/sbin/syslog-ng -F --no-caps -v -e --persist-file=/tmp/syslog-ng.persist --pidfile=/tmp/syslog-ng.pid --control=/tmp/syslog-ng.ctl