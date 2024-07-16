#!/bin/bash

KPKG_SRC_FILE=kmod-31.tar.xz
KPKG_SRC_FOLDER=kmod-31

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --with-openssl    \
              --with-xz         \
              --with-zstd       \
              --with-zlib
}

k_check() {
  :
}

k_post_install() {
  for target in depmod insmod modinfo modprobe rmmod; do
    ln -sfv ../bin/kmod /usr/sbin/$target
  done

  ln -sfv kmod /usr/bin/lsmod
}
