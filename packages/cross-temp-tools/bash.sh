#!/bin/bash

KPKG_SRC_FILE=bash-5.2.21.tar.gz
KPKG_SRC_FOLDER=bash-5.2.21

k_configure() {
  ./configure --prefix=/usr                      \
              --build=$(sh support/config.guess) \
              --host=$LFS_TGT                    \
              --without-bash-malloc
}

k_check() {
  :
}

k_pre_install() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}

k_post_install() {
  ln -sv bash $LFS/bin/sh
}
