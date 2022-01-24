#!/bin/bash -eu

LOKI_RELEASE_URL="https://github.com/grafana/loki/releases/download/v2.4.2/loki-linux-amd64.zip"

# Move work_dir
mkdir -p ./work_dir/loki/
cd ./work_dir/loki/

# DL
wget ${LOKI_RELEASE_URL}

# Copy src to /usr/local/src/
install -v `basename ${LOKI_RELEASE_URL}` /usr/local/src/

# Unzip
unzip `basename ${LOKI_RELEASE_URL}`

# Create user and group to run Loki
useradd --system --user-group --home /var/lib/loki --no-create-home --shell /sbin/nologin loki

# Copy binary to /usr/local/bin/
install -v ./loki-linux-amd64 /usr/local/bin/loki

# Copy config to /etc/loki/
install -v -D ../../config/loki.yml /etc/loki/loki.yml

# Create a directory for loki
install -v -o loki -g loki -d /var/lib/loki/
install -v -o loki -g loki -d /tmp/loki/

# Copy victoriametrics.service file to systemd
install -v ../../systemd-units/loki.service /lib/systemd/system/loki.service
