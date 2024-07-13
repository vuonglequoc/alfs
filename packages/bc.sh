#!/bin/bash

SRC_FILE=bc-6.7.5.tar.xz
SRC_FOLDER=bc-6.7.5

k_configure() {
  CC=gcc ./configure --prefix=/usr -G -O3 -r
}

k_check() {
  make test
}
