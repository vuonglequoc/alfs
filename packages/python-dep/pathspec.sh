#!/bin/bash

KPKG_SRC_FILE=pathspec-0.12.1.tar.gz
KPKG_SRC_FOLDER=pathspec-0.12.1

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
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user pathspec
}
