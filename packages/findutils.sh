#!/bin/bash

KPKG_SRC_FILE=findutils-4.10.0.tar.xz
KPKG_SRC_FOLDER=findutils-4.10.0

k_configure() {
  ./configure --prefix=/usr \
              --localstatedir=/var/lib/locate
}

k_check() {
  chown -Rv tester .
  su tester -c "PATH=$PATH make check"
}
