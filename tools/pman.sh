#!/bin/bash
#
set -e
if [ $1 == "-x" ]; then
    PACKAGE_NAME=$(basename $2 .deb)
    mkdir -p $PACKAGE_NAME/DEBIAN
    dpkg --control $2 $PACKAGE_NAME/DEBIAN
    dpkg -x $2 $PACKAGE_NAME
elif [ $1 == "-b" ]; then
    echo "   * Removing trailing slash (if present)..."
    pack_name=$(echo "$2" | sed -e "s/\/*$//")
    cd $pack_name
    echo "   * Finding and stripping binary files..."
    find . | xargs file | grep "executable" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded
    echo "   * Finding and stripping libraries..."
    find . | xargs file | grep "shared object" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded 
    echo "   * Generating the md5sum file..."
    find . -path ./DEBIAN -prune -o \! -type l | xargs file | grep -v 'directory' | cut -f 1 -d : | xargs md5sum > DEBIAN/md5sums
    cd ..
    echo "   * And finally let's buld the package!'"
    fakeroot dpkg-deb --build $pack_name $pack_name.deb
    echo
    echo
    lintian $pack_name.deb
else
	echo "Usage: $0 -b|-x TARGET"
	echo 
fi


