#!/bin/bash

KPKG_SRC_FILE=krb5-1.21.3.tar.gz
KPKG_SRC_FOLDER=krb5-1.21.3

k_pre_configure() {
  cd src
  sed -i -e '/eq 0/{N;s/12 //}'    plugins/kdb/db2/libdb2/test/run.test
}

k_configure() {
  ./configure --prefix=/usr            \
              --sysconfdir=/etc        \
              --localstatedir=/var/lib \
              --runstatedir=/run       \
              --with-system-et         \
              --with-system-ss         \
              --with-system-verto=no   \
              --enable-dns-for-realm
}

k_check() {
  make -j1 -k check
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mkdir -pv $KPKG_TMP_DIR/usr/share/doc
  cp -vfr ../doc -T $KPKG_TMP_DIR/usr/share/doc/krb5-1.21.3

  sed '/PROG_RPATH_FLAGS/d' -i $KPKG_TMP_DIR/usr/bin/krb5-config
}
