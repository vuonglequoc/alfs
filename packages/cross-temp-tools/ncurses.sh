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
  make DESTDIR=$KPKG_TMP_DIR/$LFS TIC_PATH=$(pwd)/build/progs/tic install

  ln -sv libncursesw.so $KPKG_TMP_DIR/$LFS/usr/lib/libncurses.so
  sed -e 's/^#if.*XOPEN.*$/#if 1/' \
      -i $KPKG_TMP_DIR/$LFS/usr/include/curses.h
}
