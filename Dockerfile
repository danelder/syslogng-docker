# Redhat 9
FROM registry.access.redhat.com/ubi9/ubi:latest

# Upgrade system
RUN yum --disableplugin=subscription-manager clean all

# Install python dependencies for driver
RUN yum install --disableplugin=subscription-manager -y python3-netifaces libnsl2 libxcrypt-compat

ARG VERSION=unknown

# Copy install package
COPY syslog-ng-rhel9.rpm /root/syslog-ng.rpm

# Install syslog-ng
RUN yum install --disableplugin=subscription-manager -y /root/syslog-ng.rpm

# Cache volume for disk buffer and debug output
VOLUME [ "/tmp" ]

# Always force latest configuration
ARG CACHEBUST=1

# Copy syslog-ng configuration
COPY etc/ /opt/syslog-ng/etc/

# Copy syslog-ng configuration libraries
COPY scl/ /opt/syslog-ng/share/syslog-ng/include/scl/

# Startup syslog-ng
ENTRYPOINT /opt/syslog-ng/sbin/syslog-ng -F --no-caps -v -e