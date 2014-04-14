ArcheOS
=======

This document is intended to help moving first steps in ArcheOS iso building
To obtain help with ArcheOS please refer to wiki and mailing lists.

Requisites
----------

All this software must be installed and properly configured

   1. *live-build 3.x* (http://live.debian.net/devel/live-build/)
   2. *apt-cacher-ng* (http://www.unix-ag.uni-kl.de/~bloch/acng/)

Other requirements
------------------

   1. A working Debian (wheezy/sid) or Ubuntu 13.04+ system to do the build (obviously)
   2. Ability to be superuser on the Debian/Ubuntu machine (eg. to use sudo)
   3. At least 5GB of free space
   4. (optional) a virtualization software such as qemu or virtualbox to test the iso

Build ArcheOS
-------------

*To build archeos on Ubuntu see section below*

   1. Clone the git repository with
      `git clone git://github.com/archeos/ArcheOS.git`
   2. Enter the ArcheOS/debian-live directory
      `cd ArcheOS/debian-live/`
   3. Launch the config command
      `sudo lb clean && lb config`
   4. If no errors occured during the configuration launch the build command
      `sudo lb build`
      You have to wait a long time until the build is completed...
   5. At the end of the process, if all is gone fine you should have a 
      binary.iso file in your working directory. Burn it to the cdrom
      or boot up with the virtualization software (see above)
   6. CLEAN THE ENVIRONMENT
      `sudo lb clean --purge`

Remember to run `sudo lb clean --purge` BEFORE launch again lb config to reset the 
original status

Build ArcheOS on Ubuntu
-----------------------

On Ubuntu some users complain about apt-cacher-ng errors: 
`(403  Configuration  error (confusing proxy mode) or prohibited port (see
AllowUserPorts)  [IP: 127.0.0.1 3142])`

To solve this edit (with sudo or as root) the file
*/etc/apt-cacher-ng/acng.conf* and replace the line:

`# AllowUserPorts: 80`

with:

`AllowUserPorts: 0`

and restart *apt-cacher-ng* with

`sudo service apt-cacher-ng restart`

   1. Clone the git repository with
      `git clone git://github.com/archeos/ArcheOS.git`
   2. Enter the ArcheOS/debian-live directory
      `cd ArcheOS/debian-live/`
   3. Launch the config command
      `sudo lb clean && lb config --mode debian`
   4. If no errors occured during the configuration launch the build command
      `sudo lb build`
      You have to wait a long time until the build is completed...
   5. At the end of the process, if all is gone fine you should have a 
      binary.iso file in your working directory. Burn it to the cdrom
      or boot up with the virtualization software (see above)
   6. CLEAN THE ENVIRONMENT
      `sudo lb clean --purge`

Remember to run `sudo lb clean --purge` BEFORE launch again lb config to reset the 
original status

Notes
-----   



