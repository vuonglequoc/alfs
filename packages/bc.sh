#!/bin/bash

KPKG_SRC_FILE=bc-6.7.6.tar.xz
KPKG_SRC_FOLDER=bc-6.7.6

k_configure() {
  CC=gcc ./configure --prefix=/usr -G -O3 -r
}

k_check() {
  make test
}
