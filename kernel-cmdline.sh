#!/bin/bash

CURRENT=$(grep '^GRUB_CMDLINE_LINUX=' /etc/default/grub | cut -d'"' -f2)
NEW="$CURRENT ipv6.disable=1 slab_nomerge init_on_alloc=1 init_on_free=1 page_alloc.shuffle=1 randomize_kstack_offset=on vsyscall=none debugfs=off oops=panic module.sig_enforce=1 lockdown=confidentiality kvm.nx_huge_pages=force tsx_async_abort=full,nosmt mds=full,nosmt l1tf=full,force nosmt=force"

echo ""
echo -e "\033[31m [x] Current cmdline: \033[0m" $CURRENT
echo ""
echo -e "\033[32m [x] New cmdline: \033[0m" $NEW
echo ""
echo " [x] Replace current with new cmdline"
sudo sed -i "s/^GRUB_CMDLINE_LINUX=\"\(.*\)\"$/GRUB_CMDLINE_LINUX=\"$NEW\"/" /etc/default/grub
echo ""
echo " [x] Update grub.cfg"
echo ""
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
