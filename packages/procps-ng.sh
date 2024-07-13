#!/bin/bash

SRC_FILE=procps-ng-4.0.4.tar.xz
SRC_FOLDER=procps-ng-4.0.4

k_configure() {
  ./configure --prefix=/usr                           \
              --docdir=/usr/share/doc/procps-ng-4.0.4 \
              --disable-static                        \
              --disable-kill
}

k_check() {
  make -k check
}
