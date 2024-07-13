#!/bin/bash

SRC_FILE=libcap-2.69.tar.xz
SRC_FOLDER=libcap-2.69

k_pre_configure() {
  sed -i '/install -m.*STA/d' libcap/Makefile
}

k_configure() {
  :
}

k_build() {
  make prefix=/usr lib=lib
}

k_check() {
  make test
}

k_install() {
  make prefix=/usr lib=lib install
}
