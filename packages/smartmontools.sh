#!/bin/bash

KPKG_SRC_FILE=smartmontools-7.4.tar.gz
KPKG_SRC_FOLDER=smartmontools-7.4

k_configure() {
  ./configure --prefix=/usr           \
              --sysconfdir=/etc       \
              --with-initscriptdir=no \
              --with-libsystemd=no    \
              --docdir=/usr/share/doc/smartmontools-7.4
}

k_check() {
  :
}

k_post_install() {
  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make install-smartd
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}

k_pre_record() {
  cd $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  make DESTDIR=$KPKG_TMP_DIR install

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-smartd
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
