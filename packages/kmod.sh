#!/bin/bash

KPKG_SRC_FILE=kmod-33.tar.xz
KPKG_SRC_FOLDER=kmod-33

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --with-openssl    \
              --with-xz         \
              --with-zstd       \
              --with-zlib       \
              --disable-manpages
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mkdir -pv $KPKG_TMP_DIR/usr/sbin
  for target in depmod insmod modinfo modprobe rmmod; do
    ln -sfv ../bin/kmod $KPKG_TMP_DIR/usr/sbin/$target
    rm -fv $KPKG_TMP_DIR/usr/bin/$target
  done
}
