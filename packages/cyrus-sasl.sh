#!/bin/bash

KPKG_SRC_FILE=cyrus-sasl-2.1.28.tar.gz
KPKG_SRC_FOLDER=cyrus-sasl-2.1.28

k_configure() {
  ./configure --prefix=/usr                       \
              --sysconfdir=/etc                   \
              --enable-auth-sasldb                \
              --with-dblib=lmdb                   \
              --with-dbpath=/var/lib/sasl/sasldb2 \
              --with-sphinx-build=no              \
              --with-saslauthd=/var/run/saslauthd
}

k_build() {
  make -j1
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -dm755                          $KPKG_TMP_DIR/usr/share/doc/cyrus-sasl-2.1.28/html
  install -v -m644  saslauthd/LDAP_SASLAUTHD $KPKG_TMP_DIR/usr/share/doc/cyrus-sasl-2.1.28
  install -v -m644  doc/legacy/*.html        $KPKG_TMP_DIR/usr/share/doc/cyrus-sasl-2.1.28/html
  install -v -dm700 $KPKG_TMP_DIR/var/lib/sasl

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-saslauthd
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
