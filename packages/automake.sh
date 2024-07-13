#!/bin/bash

SRC_FILE=automake-1.16.5.tar.xz
SRC_FOLDER=automake-1.16.5

k_configure() {
  ./configure --prefix=/usr \
              --docdir=/usr/share/doc/automake-1.16.5
}

k_check() {
  make -j$(($(nproc)>4?$(nproc):4)) check
}
