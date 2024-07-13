#!/bin/bash

SRC_FILE=libtool-2.4.7.tar.xz
SRC_FOLDER=libtool-2.4.7

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  make -k check
}

k_post_install() {
  rm -fv /usr/lib/libltdl.a
}
