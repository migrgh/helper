#!/bin/bash

sudo systemd-nspawn --no-new-privileges=true \
--system-call-filter=~@privileged \
--system-call-filter=~@mount \
--system-call-filter=~@clock \
--system-call-filter=~@cpu-emulation \
--system-call-filter=~@debug \
--system-call-filter=~@memlock \
--system-call-filter=~@module \
--system-call-filter=~@obsolete \
--system-call-filter=~@reboot \
--settings=false --pipe -q -U -D /var/lib/machines/$1/ /bin/bash << EOF
dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
EOF
