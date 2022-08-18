#
# Generic haproxy image for use in different places in eduID.
#

# use debian:testing to get haproxy 2.0
FROM debian:bullseye

MAINTAINER kano@sunet.se

ADD setup.sh /opt/drive/setup.sh
RUN /opt/drive/setup.sh

WORKDIR /

COPY cfgcheck.sh /cfgcheck.sh
COPY reload.sh /reload.sh

VOLUME [ "/var/run/haproxy", "/var/run/haproxy-control" ]

# This is the actual way that the image at https://hub.docker.com/_/haproxy/
# runs haproxy, but it's hidden behind a entrypoint script that modifies the arguments.
# -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
# -db -- disables background mode
CMD ["/usr/sbin/haproxy", "-p", "/run/haproxy.pid", "-f", "/etc/haproxy/haproxy.cfg", "-W", "-db"]
