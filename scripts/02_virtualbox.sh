#!/bin/bash -x

MNT=/media/virtualbox
ISO=/tmp/VBoxGuestAdditions.iso
LOG=/var/log/vboxadd-install.log
mkdir -p ${MNT}
mount -o loop,ro ${ISO} ${MNT}
sh ${MNT}/VBoxLinuxAdditions.run force
if [ -f ${LOG} ] ; then
    cat ${LOG}
fi
umount ${MNT}
rmdir ${MNT}

