#!/bin/bash

sudo dnf remove NetworkManager firewalld avahi linux-firmware-whence sssd* bluez man-db

sudo dnf install nftables amd-gpu-firmware amd-ucode-firmware
