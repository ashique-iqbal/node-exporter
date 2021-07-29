#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz

tar -xvzf node_exporter-1.1.2.linux-amd64.tar.gz

useradd -rs /bin/false node_exporter

mv node_exporter-1.1.2.linux-amd64/node_exporter /usr/local/bin/

cat << EOF >> /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
systemctl status node_exporter
exit
