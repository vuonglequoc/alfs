#!/bin/bash

KPKG_SRC_FILE=jinja2-3.1.4.tar.gz
KPKG_SRC_FOLDER=jinja2-3.1.4

k_configure() {
  :
}

k_build() {
  pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

k_check() {
  :
}

k_pre_install() {
  :
}

k_install() {
  pip3 install --no-index --no-user --find-links dist Jinja2
}
