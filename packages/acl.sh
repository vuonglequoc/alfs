#!/bin/bash

SRC_FILE=acl-2.3.2.tar.xz
SRC_FOLDER=acl-2.3.2

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/acl-2.3.2
}

k_check() {
  :
}
