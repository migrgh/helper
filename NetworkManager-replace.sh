#!/bin/bash

# get vars
IFNAME=$(ip route get 1.1.1.1 | awk '{print $5}')
GATEWAY=$(ip route | awk '/default/ { print $3 }')
IPADDR=$(ip -o -f inet addr show $INTERFACE | grep "$INTERFACE" | awk '/scope global/ {print $4}')

echo "Interface:" $IFNAME
echo "IP Address:" $IPADDR
echo "Gateway:" $GATEWAY

echo "
[Match]
Name=$IFNAME

[Network]
Address=$IPADDR
Gateway=$GATEWAY
" | sudo tee -a /etc/systemd/network/$IFNAME.network > /dev/null

sudo dnf remove NetworkManager
sudo systemctl enable systemd-networkd.service
