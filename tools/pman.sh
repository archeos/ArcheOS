#!/bin/bash
#
set -e
if [ $1 == "-x" ]; then
    PACKAGE_NAME=$(basename $2 .deb)
    mkdir -p $PACKAGE_NAME/DEBIAN
    dpkg --control $2 $PACKAGE_NAME/DEBIAN
    dpkg -x $2 $PACKAGE_NAME
elif [ $1 == "-b" ]; then
    sudo chown -R root:root $2
    dpkg -b $2 $2.deb
    echo
    echo
    lintian $2.deb
else
	echo "Usage: $0 -b|-x TARGET"
	echo 
fi


