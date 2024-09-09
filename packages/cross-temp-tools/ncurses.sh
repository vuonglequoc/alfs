#!/bin/bash

KPKG_SRC_FILE=ncurses-6.5.tar.gz
KPKG_SRC_FOLDER=ncurses-6.5

k_pre_configure() {
  sed -i s/mawk// configure

  mkdir build
  pushd build
    ../configure
    make -C include
    make -C progs tic
  popd
}

k_configure() {
  ./configure --prefix=/usr                \
              --host=$LFS_TGT              \
              --build=$(./config.guess)    \
              --mandir=/usr/share/man      \
              --with-manpage-format=normal \
              --with-shared                \
              --without-normal             \
              --with-cxx-shared            \
              --without-debug              \
              --without-ada                \
              --disable-stripping
}

k_check() {
  :
}

k_pre_install() {
  :
}

k_install() {
  make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
}

k_post_install() {
  ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
  sed -e 's/^#if.*XOPEN.*$/#if 1/' \
      -i $LFS/usr/include/curses.h
}