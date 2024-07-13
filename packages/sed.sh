#!/bin/bash

SRC_FILE=sed-4.9.tar.xz
SRC_FOLDER=sed-4.9

k_configure() {
  ./configure --prefix=/usr
}

k_build() {
  make
  make html
}

k_check() {
  chown -Rv tester .
  su tester -c "PATH=$PATH make check"
}

k_install() {
  make install
  install -d -m755           /usr/share/doc/sed-4.9
  install -m644 doc/sed.html /usr/share/doc/sed-4.9
}
