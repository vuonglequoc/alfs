#!/bin/bash

SRC_FILE=bzip2-1.0.8.tar.gz
SRC_FOLDER=bzip2-1.0.8

k_pre_configure() {
  patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch
  sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
  sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
  make -f Makefile-libbz2_so
  make clean
}

k_configure() {
  :
}

k_install() {
  make PREFIX=/usr install
}

k_post_install() {
  cp -av libbz2.so.* /usr/lib
  ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so

  cp -v bzip2-shared /usr/bin/bzip2
  for i in /usr/bin/{bzcat,bunzip2}; do
    ln -sfv bzip2 $i
  done

  rm -fv /usr/lib/libbz2.a
}
