#!/bin/bash

KPKG_SRC_FILE=attr-2.5.2.tar.gz
KPKG_SRC_FOLDER=attr-2.5.2

k_configure() {
  ./configure --prefix=/usr     \
              --disable-static  \
              --sysconfdir=/etc \
              --docdir=/usr/share/doc/attr-2.5.2
}
