#!/bin/bash

SRC_FILE=gmp-6.3.0.tar.xz
SRC_FOLDER=gmp-6.3.0

k_configure() {
./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.3.0
}

k_build() {
  make
  make html
}

k_check() {
  make check 2>&1 | tee gmp-check-log
  awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
}

k_install() {
  make install
  make install-html
}
