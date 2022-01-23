#!/bin/bash -eu

RELEASE_URL="https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v1.72.0/victoria-metrics-amd64-v1.72.0.tar.gz"

# Move work_dir
mkdir -p ./work_dir/victoriametrics/
cd ./work_dir/victoriametrics/

# DL
wget ${RELEASE_URL}

# Copy src to /usr/local/src/
install -v `basename ${RELEASE_URL}` /usr/local/src/

# Unzip
tar -xzvf `basename ${RELEASE_URL}`

# Create user and group to run VictoriaMetrics
useradd --system --user-group --home /var/lib/victoriametrics --no-create-home --shell /sbin/nologin victoriametrics

# Copy binary to /usr/local/bin/
install -v ./victoria-metrics-prod /usr/local/bin/victoriametrics

# Copy config to /etc/victoriametrics/
install -v -D ../config/victoriametrics.yml /etc/victoriametrics/victoriametrics.yml

# Create a directory for victoriametrics
install -v -o victoriametrics -g victoriametrics -d /var/lib/victoriametrics/

# Copy victoriametrics.service file to systemd
install -v ../systemd-units/victoriametrics.service /lib/systemd/system/victoriametrics.service
