#!/bin/bash

SRC_FILE=zlib-1.3.1.tar.gz
SRC_FOLDER=zlib-1.3.1

k_configure() {
  ./configure --prefix=/usr
}

k_post_install() {
  rm -fv /usr/lib/libz.a
}
