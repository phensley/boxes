#!/bin/bash -xe

if [[ ${CACHEDIR} == "" ]] ; then
    CACHEDIR=/tmp
fi

JDK_RPM="${CACHEDIR}/jdk.rpm"
JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm"
JDK_SHA="dd11d03059f7835f7965d1db96b26e21f47b04dfe7b285ce94d64200156b3ed6"

MESOS_RPM="${CACHEDIR}/mesos-repo.rpm"
MESOS_URL="http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-2.noarch.rpm"
MESOS_SHA="dcb7cfb9731c0764cee15032fb8142f06c068a7f8058f18b91146cca3d22277c"

VAGRANT_KEY="${CACHEDIR}/vagrant-key.pub"
VAGRANT_URL="https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub"
VAGRANT_SHA="9aa9292172c915821e29bcbf5ff42d4940f59d6a148153c76ad638f5f4c6cd8b"

function check
{
    FILE=$1
    EXPECTED=$2
    DIGEST=`sha256sum ${FILE} | cut -d' ' -f1`
    if [ ${DIGEST} != ${EXPECTED} ] ; then
        echo "Error!! sha256 failed for ${FILE}"
        echo "expected: ${EXPECTED}"
        echo "  actual: ${DIGEST}"
        exit 1
    fi
    echo "sha256 for ${FILE} is ok"
}

function download_jdk_rpm
{
    if [ ! -f ${JDK_RPM} ] ; then
        echo "downloading ${JDK_URL} -> {$JDK_RPM}"
        wget --no-check-certificate --no-cookies \
            --header "Cookie: oraclelicense=accept-securebackup-cookie" \
            -O ${JDK_RPM} \
            ${JDK_URL}
    fi
    check ${JDK_RPM} ${JDK_SHA}
}

function download_mesos_rpm
{
    if [ ! -f ${MESOS_RPM} ] ; then
        echo "downloading ${MESOS_URL} -> ${MESOS_RPM}"
        wget -O ${MESOS_RPM} ${MESOS_URL}
    fi
    check ${MESOS_RPM} ${MESOS_SHA}
}

function download_vagrant_key
{
    if [ ! -f ${VAGRANT_KEY} ] ; then
        echo "downloading ${VAGRANT_URL} -> ${VAGRANT_RPM}"
        wget --no-check-certificate \
            -O ${VAGRANT_KEY} \
            ${VAGRANT_URL}
    fi
    check ${VAGRANT_KEY} ${VAGRANT_SHA}
}


