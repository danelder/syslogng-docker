# Redhat 8 
FROM registry.access.redhat.com/ubi8/ubi:latest

# Upgrade system
RUN yum --disableplugin=subscription-manager clean all

# Install python dependency for driver
RUN yum install --disableplugin=subscription-manager -y python3-netifaces libnsl2 python3

ARG VERSION=20240624

# Copy install package
COPY syslog-ng-premium-edition-compact-7.0.34-1.rhel9.x86_64.rpm /root/syslog-ng.rpm

# Install syslog-ng
RUN yum install --disableplugin=subscription-manager -y /root/syslog-ng.rpm

# Cache volume for disk buffer and debug output
VOLUME [ "/tmp" ]

# Configuration volume for syslog-ng 
VOLUME [ "/opt/syslog-ng/etc" ]

# Custom SCL volume for syslog-ng
VOLUME [ "/opt/syslog-ng/share/syslog-ng/include/scl/" ]

# Startup syslog-ng
ENTRYPOINT /opt/syslog-ng/sbin/syslog-ng -F --no-caps -v -e