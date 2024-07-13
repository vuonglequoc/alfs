#!/bin/bash

SRC_FILE=
SRC_FOLDER=

k_pre_configure() {
  :
}

k_configure() {
  ./configure
}

k_build() {
  make
}

k_check() {
  make check
}

k_install() {
  make install
}

k_post_install() {
  :
}
