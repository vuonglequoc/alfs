#!/bin/bash

KPKG_SRC_FILE=dhcpcd-10.0.8.tar.xz
KPKG_SRC_FOLDER=dhcpcd-10.0.8

k_configure() {
  ./configure --prefix=/usr                \
              --sysconfdir=/etc            \
              --libexecdir=/usr/lib/dhcpcd \
              --dbdir=/var/lib/dhcpcd      \
              --runstatedir=/run           \
              --disable-privsep
}

k_check() {
  make test
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR install

cd $KPKG_ROOT/sources
tar -xf blfs-bootscripts-20240416.tar.xz
cd blfs-bootscripts-20240416
make DESTDIR=$KPKG_TMP_DIR install-service-dhcpcd
cd $KPKG_ROOT/sources
rm -r blfs-bootscripts-20240416

mkdir -pv $KPKG_TMP_DIR/etc/sysconfig
cat > $KPKG_TMP_DIR/etc/sysconfig/ifconfig.eth0 << "EOF"
ONBOOT="yes"
IFACE="eth0"
SERVICE="dhcpcd"
DHCP_START="-b -q -h $HOSTNAME"
DHCP_STOP="-k"
EOF
}
