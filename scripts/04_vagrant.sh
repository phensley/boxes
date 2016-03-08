#!/bin/bash -x

. $(cd `dirname $0`; pwd)/includes.sh

SSHDIR=/home/vagrant/.ssh
mkdir -p ${SSHDIR}

download_vagrant_key
mv ${VAGRANT_KEY} ${SSHDIR}/authorized_keys

chown -R vagrant:vagrant ${SSHDIR}
chmod 700 ${SSHDIR}
chmod 600 ${SSHDIR}/authorized_keys

