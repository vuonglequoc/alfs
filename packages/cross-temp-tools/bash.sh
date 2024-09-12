#!/bin/bash

KPKG_SRC_FILE=bash-5.2.32.tar.gz
KPKG_SRC_FOLDER=bash-5.2.32

k_configure() {
  ./configure --prefix=/usr                      \
              --build=$(sh support/config.guess) \
              --host=$LFS_TGT                    \
              --without-bash-malloc              \
              bash_cv_strtold_broken=no
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install

  ln -sv bash $KPKG_TMP_DIR/$LFS/bin/sh
}
