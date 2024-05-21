#!/bin/bash

CURRENT=$(grep '^OPTIONS=' /etc/sysconfig/chronyd | cut -d'"' -f2)
NEW="$CURRENT -4"

echo $CURRENT
echo $NEW
sudo sed -i "s/^OPTIONS=\"\(.*\)\"$/OPTIONS=\"$NEW\"/" /etc/sysconfig/chronyd

GATEWAY=$(ip route | awk '/default/ { print $3 }')

sudo sed -i "s/pool 2\.fedora\.pool\.ntp\.org iburst/server $GATEWAY/" /etc/chrony.conf
sudo sed -i 's/^sourcedir \/run\/chrony-dhcp/#&/' /etc/chrony.conf

sudo dnf install chrony
sudo systemctl enable chronyd
sudo systemctl restart chronyd

sudo journalctl -u chronyd --since="-1m"
