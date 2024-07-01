# Redhat 9
FROM registry.access.redhat.com/ubi9/ubi:latest

# Upgrade system
RUN dnf --disableplugin=subscription-manager clean all

# Install python dependencies for driver
RUN dnf install --disableplugin=subscription-manager -y python3-netifaces libnsl2 libxcrypt-compat

ARG VERSION=20240628

# Copy install package
RUN curl -o /root/syslog-ng.rpm -L "https://www.dropbox.com/scl/fi/b9atj7f0ul5j1fiy1aotf/syslog-ng-premium-edition-compact-7.0.34-1.rhel9.x86_64.rpm?rlkey=2kcoomhi3d5jmllfq8trrbmgo&st=gktoqzoc&dl=0"

# Install syslog-ng
RUN dnf install --disableplugin=subscription-manager -y /root/syslog-ng.rpm

# Cache volume for disk buffer, state, and debug output
VOLUME [ "/tmp" ]

# Always force latest configuration
#ARG CACHEBUST=1

# Copy syslog-ng configuration
COPY etc/ /opt/syslog-ng/etc/

# Copy syslog-ng configuration libraries
COPY scl/ /opt/syslog-ng/share/syslog-ng/include/scl/

# Startup syslog-ng
ENTRYPOINT /opt/syslog-ng/sbin/syslog-ng -F --no-caps -v -e --persist-file=/tmp/syslog-ng.persist --pidfile=/tmp/syslog-ng.pid --control=/tmp/syslog-ng.ctl