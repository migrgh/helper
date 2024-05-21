#!/bin/bash

IFNAME=$(ip route get 1.1.1.1 | awk '{print $5}')
GATEWAY=$(ip route | awk '/default/ { print $3 }')
IPADDR=$(ip -o -f inet addr show $INTERFACE | grep "$INTERFACE" | awk '/scope global/ {print $4}')

echo "#!/usr/sbin/nft -f
flush ruleset
define oiface={"$IFNAME"}
define gateway={"$GATEWAY"}
define myip={"$IPADDR"}
table inet filter {
        chain input {
                type filter hook input priority filter; policy drop;
                ct state invalid drop
                ct state {established,related} accept
                iifname lo ip saddr 127.0.0.1 accept
                drop
        }
        chain forward {
                type filter hook forward priority filter; policy drop;
                drop
        }
        chain output {
                type filter hook output priority filter; policy drop;
                ct state invalid drop
                ct state {established,related} accept
                oifname lo ip daddr 127.0.0.1 accept
                oifname $IFNAME ip daddr $GATEWAY udp dport 53 accept
                oifname $IFNAME ip daddr $GATEWAY udp dport 123 accept
                drop
        }
}" | sudo tee /etc/sysconfig/nftables.conf > /dev/null

sudo dnf remove firewalld
sudo dnf install nftables
sudo systemctl restart nftables.service
sudo systemctl enable nftables.service
