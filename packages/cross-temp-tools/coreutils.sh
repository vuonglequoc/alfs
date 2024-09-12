#!/bin/bash

KPKG_SRC_FILE=coreutils-9.5.tar.xz
KPKG_SRC_FOLDER=coreutils-9.5

k_configure() {
  ./configure --prefix=/usr                     \
              --host=$LFS_TGT                   \
              --build=$(build-aux/config.guess) \
              --enable-install-program=hostname \
              --enable-no-install-program=kill,uptime
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install

  mkdir -pv $KPKG_TMP_DIR/$LFS/usr/sbin
  mv -v $KPKG_TMP_DIR/$LFS/usr/bin/chroot               $KPKG_TMP_DIR/$LFS/usr/sbin
  mkdir -pv $KPKG_TMP_DIR/$LFS/usr/share/man/man8
  mv -v $KPKG_TMP_DIR/$LFS/usr/share/man/man1/chroot.1  $KPKG_TMP_DIR/$LFS/usr/share/man/man8/chroot.8
  sed -i 's/"1"/"8"/'                                   $KPKG_TMP_DIR/$LFS/usr/share/man/man8/chroot.8
}
