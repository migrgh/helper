#!/bin/bash

STOP="wsdd systemd-resolved systemd-timesyncd systemd-timedated systemd-homed systemd-userdbd systemd-userdbd.socket"

sudo systemctl stop $STOP
sudo systemctl mask $STOP
sudo systemctl daemon-reload
