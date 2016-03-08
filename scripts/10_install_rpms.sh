#!/bin/bash -xe

. $(cd `dirname $0`; pwd)/includes.sh

download_jdk_rpm
download_mesos_rpm

rpm -Uvh ${JDK_RPM}
rpm -Uvh ${MESOS_RPM}

