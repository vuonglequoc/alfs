#!/bin/bash

KPKG_SRC_FILE=dosfstools-4.2.tar.gz
KPKG_SRC_FOLDER=dosfstools-4.2

k_configure() {
  ./configure --prefix=/usr            \
              --enable-compat-symlinks \
              --mandir=/usr/share/man  \
              --docdir=/usr/share/doc/dosfstools-4.2
}
