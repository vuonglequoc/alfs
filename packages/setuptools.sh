#!/bin/bash

SRC_FILE=setuptools-69.1.0.tar.gz
SRC_FOLDER=setuptools-69.1.0

k_configure() {
  :
}

k_build() {
  pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

k_check() {
  :
}

k_install() {
  pip3 install --no-index --find-links dist setuptools
}
