#!/bin/bash -x

sed -ri 's/SELINUX=(enforcing|permissive)/SELINUX=disabled/g' \
    /etc/sysconfig/selinux \
    /etc/selinux/config
setenforce 0
getenforce


