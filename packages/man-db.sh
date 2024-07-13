#!/bin/bash

SRC_FILE=man-db-2.12.0.tar.xz
SRC_FOLDER=man-db-2.12.0

k_configure() {
  ./configure --prefix=/usr                         \
              --docdir=/usr/share/doc/man-db-2.12.0 \
              --sysconfdir=/etc                     \
              --disable-setuid                      \
              --enable-cache-owner=bin              \
              --with-browser=/usr/bin/lynx          \
              --with-vgrind=/usr/bin/vgrind         \
              --with-grap=/usr/bin/grap             \
              --with-systemdtmpfilesdir=            \
              --with-systemdsystemunitdir=
}
