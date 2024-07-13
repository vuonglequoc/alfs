#!/bin/bash

SRC_FILE=gperf-3.1.tar.gz
SRC_FOLDER=gperf-3.1

k_configure() {
  ./configure --prefix=/usr \
              --docdir=/usr/share/doc/gperf-3.1
}

k_check() {
  make -j1 check
}
