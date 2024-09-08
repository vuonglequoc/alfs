#!/bin/bash

KPKG_SRC_FILE=ply-3.11.tar.gz
KPKG_SRC_FOLDER=ply-3.11

k_configure() {
  :
}

k_build() {
  pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD
}

k_check() {
  :
}

k_pre_install() {
  :
}

k_install() {
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user ply
}
