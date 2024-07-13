#!/bin/bash

SRC_FILE=libffi-3.4.4.tar.gz
SRC_FOLDER=libffi-3.4.4

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --with-gcc-arch=native
}
