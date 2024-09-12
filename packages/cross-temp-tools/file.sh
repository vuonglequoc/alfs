#!/bin/bash

KPKG_SRC_FILE=file-5.45.tar.gz
KPKG_SRC_FOLDER=file-5.45

k_pre_configure() {
  mkdir build
  pushd build
    ../configure --disable-bzlib      \
                 --disable-libseccomp \
                 --disable-xzlib      \
                 --disable-zlib
    make
  popd
}

k_configure() {
  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(./config.guess)
}

k_build() {
  make FILE_COMPILE=$(pwd)/build/src/file
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install

  rm -v $KPKG_TMP_DIR/$LFS/usr/lib/libmagic.la
}
