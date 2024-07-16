#!/bin/bash

KPKG_SRC_FILE=make-4.4.1.tar.gz
KPKG_SRC_FOLDER=make-4.4.1

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  chown -Rv tester .
  su tester -c "PATH=$PATH make check"
}
