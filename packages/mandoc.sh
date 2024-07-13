#!/bin/bash

SRC_FILE=mandoc-1.14.6.tar.gz
SRC_FOLDER=mandoc-1.14.6

k_build() {
  make mandoc
  make regress
}

k_check() {
  :
}

k_install() {
  install -vm755 mandoc   /usr/bin
  install -vm644 mandoc.1 /usr/share/man/man1
}
