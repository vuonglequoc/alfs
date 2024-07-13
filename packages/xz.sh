#!/bin/bash

SRC_FILE=xz-5.4.6.tar.xz
SRC_FOLDER=xz-5.4.6

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/xz-5.4.6
}
