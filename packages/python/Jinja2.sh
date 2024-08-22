#!/bin/bash

KPKG_SRC_FILE=Jinja2-3.1.3.tar.gz
KPKG_SRC_FOLDER=Jinja2-3.1.3

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
  pip3 install --no-index --no-user --find-links dist Jinja2
}

k_pre_record() {
  :
}

k_record() {
  :
}
