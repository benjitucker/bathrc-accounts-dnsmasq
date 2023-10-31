#!/bin/sh

# Use the nameservers provided by the ECS environment for dnsmasq recursive resolution, making sure that there is no
# localhost entry.
grep -v "127.0.0.1" /etc/resolv.conf > /etc/resolv.dnsmasq

# Add localhost nameserver (dnsmasq) as the first to try to resolve an address. Note, because this container is
# designed to be a sidecar, ECS (Docker) mounts the same resolve.conf file into both the main container and this
# sidecar. Also, being a sidecar the dnsmasq resolver running in this container can be reached by the main container
# via localhost.
echo -e "nameserver 127.0.0.1\n$(cat /etc/resolv.conf)" > /etc/resolv.conf

cat /etc/resolv.conf
exec dnsmasq -k
