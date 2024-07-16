#!/bin/bash

KPKG_SRC_FILE=expat-2.6.0.tar.xz
KPKG_SRC_FOLDER=expat-2.6.0

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/expat-2.6.0
}

k_post_install() {
  install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.6.0
}
