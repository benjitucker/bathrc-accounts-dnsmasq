FROM alpine:latest
RUN apk --no-cache add dnsmasq bind-tools
RUN mkdir -p /run/dnsmasq
RUN touch /run/dnsmasq/dnsmasq.pid

COPY files/healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh

COPY ./files/dnsmasq.conf /etc/dnsmasq.d/custom.conf

# COPY startup_script
COPY files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 53 53/udp

ENTRYPOINT ["/entrypoint.sh"]
