#!/bin/bash

KPKG_SRC_FILE=libsndfile-1.2.2.tar.xz
KPKG_SRC_FOLDER=libsndfile-1.2.2

k_configure() {
  ./configure --prefix=/usr \
              --docdir=/usr/share/doc/libsndfile-1.2.2
}
