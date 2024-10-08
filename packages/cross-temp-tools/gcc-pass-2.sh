#!/bin/bash

KPKG_SRC_FILE=gcc-14.2.0.tar.xz
KPKG_SRC_FOLDER=gcc-14.2.0

k_pre_configure() {
  tar -xf ../mpfr-4.2.1.tar.xz
  mv -v mpfr-4.2.1 mpfr
  tar -xf ../gmp-6.3.0.tar.xz
  mv -v gmp-6.3.0 gmp
  tar -xf ../mpc-1.3.1.tar.gz
  mv -v mpc-1.3.1 mpc

  case $(uname -m) in
    x86_64)
      sed -e '/m64=/s/lib64/lib/' \
          -i.orig gcc/config/i386/t-linux64
    ;;
  esac

  sed '/thread_header =/s/@.*@/gthr-posix.h/' \
      -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

  mkdir -v build
  cd       build
}

k_configure() {
  ../configure                                  \
      --build=$(../config.guess)                \
      --host=$LFS_TGT                           \
      --target=$LFS_TGT                         \
      LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
      --prefix=/usr                             \
      --with-build-sysroot=$LFS                 \
      --enable-default-pie                      \
      --enable-default-ssp                      \
      --disable-nls                             \
      --disable-multilib                        \
      --disable-libatomic                       \
      --disable-libgomp                         \
      --disable-libquadmath                     \
      --disable-libsanitizer                    \
      --disable-libssp                          \
      --disable-libvtv                          \
      --enable-languages=c,c++

  ulimit -s 32768
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install

  ln -sv gcc $KPKG_TMP_DIR/$LFS/usr/bin/cc
  ln -sv gcc $KPKG_TMP_DIR/$LFS/usr/bin/cc1
}
