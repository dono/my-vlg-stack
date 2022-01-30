#!/bin/bash -eu

RELEASE_URL="https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz"

gz=`basename ${RELEASE_URL}`
dir=`basename ${gz} .tar.gz`

# Move work_dir
mkdir -p ./work_dir/node_exporter/
cd ./work_dir/node_exporter/

# DL
wget ${RELEASE_URL}

# Copy src to /usr/local/src/
install -v `basename ${RELEASE_URL}` /usr/local/src/

# Unzip
tar -xzvf ${gz}

# Copy binary to /usr/local/bin/
install -v ${dir}/node_exporter /usr/local/bin/

# Copy loki.service file to systemd
install -v ../../systemd-units/node_exporter.service /lib/systemd/system/node_exporter.service
