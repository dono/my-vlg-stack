#!/bin/bash


RELEASE_URL="https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v1.71.0/victoria-metrics-amd64-v1.71.0.tar.gz"


set -e

# Move work_dir
mkdir ./work_dir
cd ./work_dir

# DL
wget ${RELEASE_URL}

# Copy src to /usr/local/src
install -v `basename ${RELEASE_URL}` /usr/local/src/

# Unzip
tar -xzvf `basename ${RELEASE_URL}`

# Create user and group to run VictoriaMetrics
useradd --system --user-group --home /var/lib/victoriametrics --no-create-home --shell /sbin/nologin victoriametrics

# Copy binary to /usr/bin
install -v ./victoria-metrics-prod /usr/local/bin/victoriametrics

# Copy config to /etc/victoriametrics/
install -v -D ../config/victoriametrics.yml /etc/victoriametrics/victoriametrics.yml

# Create a directory for victoriametrics
install -v -o victoriametrics -g victoriametrics -d /var/lib/victoriametrics/

# Copy victoriametrics.service file to systemd
install -v ../systemd-units/victoriametrics.service /lib/systemd/system/victoriametrics.service
