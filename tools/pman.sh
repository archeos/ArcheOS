#!/bin/bash
#
set -e
if [ $1 == "-x" ]; then
    PACKAGE_NAME=$(basename $2 .deb)
    mkdir -p $PACKAGE_NAME/DEBIAN
    dpkg --control $2 $PACKAGE_NAME/DEBIAN
    dpkg -x $2 $PACKAGE_NAME
elif [ $1 == "-b" ]; then
    echo "   * Setting permissions..."
    sudo chown -R root:root $2
    echo "   * Removing trailing slash (if present)..."
    pack_name=$(echo "$2" | sed -e "s/\/*$//")
    cd $pack_name
    echo "   * Generating the md5sum file..."
    md5sum $(find . -type f | grep -v '^\.\/DEBIAN/') > DEBIAN/md5sums
    cd ..
    echo "   * And finally let's buld the package!'"
    dpkg -b $pack_name $pack_name.deb
    echo
    echo
    lintian $pack_name.deb
else
	echo "Usage: $0 -b|-x TARGET"
	echo 
fi


