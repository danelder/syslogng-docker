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

# Cache volume for disk buffer, state, and debug output
VOLUME [ "/tmp" ]

# Copy syslog-ng configuration
COPY etc/ /opt/syslog-ng/etc/

# Copy syslog-ng configuration libraries
COPY syslog-ng-drivers/scl/. /opt/syslog-ng/share/syslog-ng/include/scl/

# Copy entrypoint 
COPY entrypoint.sh /

# Startup syslog-ng
ENTRYPOINT /entrypoint.sh