#!/bin/bash -x

yum -y install epel-release

PACKAGES="
bzip2 
dkms 
gcc 
kernel-devel 
kernel-headers 
make
NetworkManager 
NetworkManager-tui 
NetworkManager-wifi
ntp 
vim-enhanced 
wget
"

yum -y install ${PACKAGES}
yum -y update

reboot
sleep 60

