#!/bin/bash
#
set -e
if [ $1 == "-x" ]; then
    PACKAGE_NAME=$(basename $2 .deb)
    mkdir -p $PACKAGE_NAME/DEBIAN
    dpkg --control $2 $PACKAGE_NAME/DEBIAN
    dpkg -x $2 $PACKAGE_NAME
fi
if [ $1 == "-b" ]; then
    sudo chown -R root:root $2
    dpkg -b $2 $2.deb
    lintian $2.deb
fi


echo "finito!"
