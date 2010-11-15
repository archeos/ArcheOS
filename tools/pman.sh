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
    pack_name=$(echo "$2" | sed -e "s/\/*$//")
    cd $pack_name
    md5sum $(find . -type f | grep -v '^\.\/DEBIAN/') > DEBIAN/md5sums
    cd ..
    dpkg -b $pack_name $pack_name.deb
    echo
    echo
    lintian $pack_name.deb
else
	echo "Usage: $0 -b|-x TARGET"
	echo 
fi


