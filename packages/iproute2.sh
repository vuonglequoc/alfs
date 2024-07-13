#!/bin/bash

SRC_FILE=iproute2-6.7.0.tar.xz
SRC_FOLDER=iproute2-6.7.0

k_pre_configure() {
  sed -i /ARPD/d Makefile
  rm -fv man/man8/arpd.8
}

k_configure() {
  :
}

k_build() {
  make NETNS_RUN_DIR=/run/netns
}

k_check() {
  :
}

k_install() {
  make SBINDIR=/usr/sbin install
}

k_post_install() {
  mkdir -pv             /usr/share/doc/iproute2-6.7.0
  cp -v COPYING README* /usr/share/doc/iproute2-6.7.0
}
