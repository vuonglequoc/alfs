#!/bin/bash

KPKG_SRC_FILE=libarchive-3.7.4.tar.xz
KPKG_SRC_FOLDER=libarchive-3.7.4

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  LC_ALL=C make check
}
