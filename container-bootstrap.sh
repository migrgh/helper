#!/bin/bash

sudo mkdir /var/lib/machines/$1
sudo dnf --releasever=40 --best --setopt=install_weak_deps=False --installroot=/var/lib/machines/$1/ \
install dnf fedora-release glibc glibc-langpack-en glibc-langpack-de systemd
