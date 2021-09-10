# start from debian 10 slim version
FROM debian:buster-slim

# install certbot, supervisor and utilities
RUN apt-get update && apt-get install --no-install-recommends -yqq \
    apt-transport-https \
    ca-certificates \
    cron \
    curl \
    gettext \
    gnupg \
    iproute2 \
    procps \
    wget \
    && apt-get clean autoclean && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# install haproxy from official debian repos (https://haproxy.debian.net/)
RUN curl https://haproxy.debian.net/bernat.debian.org.gpg | apt-key add -
RUN echo deb http://haproxy.debian.net buster-backports-2.4 main | tee /etc/apt/sources.list.d/haproxy.list
RUN apt-get update \
    && apt-get install -yqq haproxy=2.4.\* \
    && apt-get clean autoclean && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /jail

EXPOSE 80 443 6039

