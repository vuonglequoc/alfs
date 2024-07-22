#!/bin/bash

KPKG_SRC_FILE=nspr-4.35.tar.gz
KPKG_SRC_FOLDER=nspr-4.35

k_pre_configure() {
  cd nspr

  sed -i '/^RELEASE/s|^|#|' pr/src/misc/Makefile.in
  sed -i 's|$(LIBRARY) ||'  config/rules.mk
}

k_configure() {
  ./configure --prefix=/usr   \
              --with-mozilla  \
              --with-pthreads \
              $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
}

k_check() {
  :
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install
}
