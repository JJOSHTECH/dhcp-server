# Use a Debian Image
FROM arm32v7/debian:stretch-slim

#ARM Support
COPY qemu-arm-static /usr/bin

# Update and Upgrade Repo
RUN apt update && apt full-upgrade -y && apt autoremove && apt clean

# Install ClamAV Deamon
RUN apt install isc-dhcp-server -y

# Configuration Volumes
VOLUME ["/etc/dhcp/"]

# Define Environment Variables
ENV DOMAIN_NAME="DOCKER"
ENV NAMESERVER_1="1.1.1.1"
ENV NAMESERVER_2="9.9.9.9"
ENV DEFAULT_LEASE_TIME="600"
ENV MAX_LEASE_TIME="7200"
ENV SUBNET="192.168.0.0"
ENV NETMASK="255.255.255.0"
ENV NETWORK_RANGE_LOW="192.168.0.10"
ENV NETWORK_RANGE_HIGH="192.168.0.50"
ENV DEFAULT_GATEWAY="192.168.0.1"
ENV BROADCAST="192.168.0.255"

# Copy default clamd configuration into container
COPY ./conf/dhcpd.conf /etc/dhcp/dhcpd.conf
RUN touch /var/lib/dhcp/dhcpd.leases

# ADD startUP.sh script into container and make runable
COPY ./startUP.sh ./startUP.sh
RUN chmod +x ./startUP.sh

# Start Update Virus Database and CLAMAV in foregournd
ENTRYPOINT ["./startUP.sh"]
CMD ["dhcpd"]
