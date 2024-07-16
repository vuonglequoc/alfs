#!/bin/bash

KPKG_SRC_FILE=pkgconf-2.1.1.tar.xz
KPKG_SRC_FOLDER=pkgconf-2.1.1

k_configure() {
./configure --prefix=/usr              \
            --disable-static           \
            --docdir=/usr/share/doc/pkgconf-2.1.1
}

k_check() {
  :
}

k_post_install() {
  ln -sv pkgconf   /usr/bin/pkg-config
  ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1
}
