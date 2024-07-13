#!/bin/bash

SRC_FILE=gettext-0.22.4.tar.xz
SRC_FOLDER=gettext-0.22.4

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/gettext-0.22.4
}

k_post_install() {
  chmod -v 0755 /usr/lib/preloadable_libintl.so
}
