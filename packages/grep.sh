#!/bin/bash

SRC_FILE=grep-3.11.tar.xz
SRC_FOLDER=grep-3.11

k_pre_configure() {
  sed -i "s/echo/#echo/" src/egrep.sh
}

k_configure() {
  ./configure --prefix=/usr
}
