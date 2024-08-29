#!/bin/bash

if [ -z "$NONROOT_USER" ]
  then echo "Please check environment variable NONROOT_USER"
  exit
fi

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages sudo

groupadd $NONROOT_USER
useradd -s /bin/bash -g $NONROOT_USER -m -k /dev/null $NONROOT_USER
# passwd user
echo "$NONROOT_USER:$NONROOT_USER" | chpasswd
usermod -aG wheel $NONROOT_USER

kpkg_install /alfs packages openssh
kpkg_install /alfs packages wget

# Ignore Certificate Check because we have not yet install make-ca
echo "check_certificate = off" >> /home/$NONROOT_USER/.wgetrc

exit
