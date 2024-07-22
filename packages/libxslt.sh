#!/bin/bash

KPKG_SRC_FILE=libxslt-1.1.42.tar.xz
KPKG_SRC_FOLDER=libxslt-1.1.42

k_configure() {
  ./configure --prefix=/usr                          \
              --disable-static                       \
              --docdir=/usr/share/doc/libxslt-1.1.42 \
              PYTHON=/usr/bin/python3
}
