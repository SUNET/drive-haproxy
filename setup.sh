#!/bin/bash

set -e

apt-get update
apt-get -y dist-upgrade
# Some of these are installed because they are used by the SUNET frontends
# to check for interface status, other containers etc.
apt-get -y install \
	curl \
	haproxy=2.2.\* \
	inotify-tools \
	iproute2 \
	iputils-ping \
	net-tools \
	netcat-openbsd \
	vim \
	procps

# save space
rm -rf /var/lib/apt/lists/*
