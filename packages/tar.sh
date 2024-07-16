#!/bin/bash

KPKG_SRC_FILE=tar-1.35.tar.xz
KPKG_SRC_FOLDER=tar-1.35

k_configure() {
  FORCE_UNSAFE_CONFIGURE=1  \
  ./configure --prefix=/usr
}

k_post_install() {
  make -C doc install-html docdir=/usr/share/doc/tar-1.35
}
