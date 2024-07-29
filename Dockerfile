# Redhat 9
FROM registry.access.redhat.com/ubi9/ubi:latest

# Upgrade system
RUN dnf --disableplugin=subscription-manager clean all

# Install python dependencies for driver
RUN dnf install --disableplugin=subscription-manager -y python3-netifaces libnsl2 libxcrypt-compat

# Get RPM path from environment
ARG RPM
ENV RPM_PATH=${RPM}

# Set environment variable for running in a container
ENV confgen_container=true

# Install syslog-ng
RUN rpm -Uvh ${RPM_PATH}

# Install required Python packages for additional drivers
RUN /opt/syslog-ng/bin/python3 -m pip install boto3
RUN /opt/syslog-ng/bin/python3 -m pip install websocket-client
RUN /opt/syslog-ng/bin/python3 -m pip install pytz
RUN /opt/syslog-ng/bin/python3 -m pip install py-zabbix
RUN /opt/syslog-ng/bin/python3 -m pip install --upgrade certifi

# Cache volume for disk buffer, state, and debug output
VOLUME [ "/tmp" ]

# Ensure no caching of content beyond this point
ARG CACHEBUST
ENV CACHE_BUST=${CACHEBUST}

# Copy syslog-ng configuration
COPY etc/ /opt/syslog-ng/etc/

# Copy syslog-ng configuration libraries
COPY syslog-ng-drivers/scl/. /opt/syslog-ng/share/syslog-ng/include/scl/

# Startup syslog-ng
ENTRYPOINT confgen_container=true /opt/syslog-ng/sbin/syslog-ng -F --no-caps -v -e --persist-file=/tmp/syslog-ng.persist --pidfile=/tmp/syslog-ng.pid --control=/tmp/syslog-ng.ctl
