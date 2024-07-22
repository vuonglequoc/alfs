#!/bin/bash

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages sudo

groupadd user
useradd -s /bin/bash -g user -m -k /dev/null user
# passwd user
echo 'user:user' | chpasswd
usermod -aG wheel user

kpkg_install /alfs packages openssh
kpkg_install /alfs packages wget

# Ignore Certificate Check because we have not yet install make-ca
echo "check_certificate = off" >> ~/.wgetrc

exit
