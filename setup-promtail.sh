#!/bin/bash -eu

RELEASE_URL="https://github.com/grafana/loki/releases/download/v2.4.2/promtail-linux-amd64.zip"

# Move work_dir
mkdir -p ./work_dir/promtail/
cd ./work_dir/promtail/

# DL
wget ${RELEASE_URL}

# Copy src to /usr/local/src/
install -v `basename ${RELEASE_URL}` /usr/local/src/

# Unzip
unzip `basename ${RELEASE_URL}`

set +e
# Create user and group to run Loki & Promtail
useradd --system --user-group --home /var/lib/loki --no-create-home --shell /sbin/nologin loki
usermod -a -G adm loki
set -e

# Copy binary to /usr/local/bin/
install -v ./promtail-linux-amd64 /usr/local/bin/promtail

# Copy config to /etc/promtail/
install -v -D ../../config/promtail.yml /etc/promtail/promtail.yml

# Create a directory for promtail
install -v -o loki -g loki -d /tmp/promtail/

# Copy promtail.service file to systemd
install -v ../../systemd-units/promtail.service /lib/systemd/system/promtail.service
