#!/bin/bash

KPKG_SRC_FILE=pinentry-1.3.1.tar.bz2
KPKG_SRC_FOLDER=pinentry-1.3.1

k_configure() {
  ./configure --prefix=/usr --enable-pinentry-tty
}

k_check() {
  :
}
