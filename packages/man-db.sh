#!/bin/bash

KPKG_SRC_FILE=man-db-2.12.1.tar.xz
KPKG_SRC_FOLDER=man-db-2.12.1

k_configure() {
  ./configure --prefix=/usr                         \
              --docdir=/usr/share/doc/man-db-2.12.1 \
              --sysconfdir=/etc                     \
              --disable-setuid                      \
              --enable-cache-owner=bin              \
              --with-browser=/usr/bin/lynx          \
              --with-vgrind=/usr/bin/vgrind         \
              --with-grap=/usr/bin/grap             \
              --with-systemdtmpfilesdir=            \
              --with-systemdsystemunitdir=
}
