#!/bin/bash

SRC_FILE=gcc-13.2.0.tar.xz
SRC_FOLDER=gcc-13.2.0

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

  mkdir -v build
  cd       build
}

k_configure() {
  ../configure                  \
      --target=$LFS_TGT         \
      --prefix=$LFS/tools       \
      --with-glibc-version=2.39 \
      --with-sysroot=$LFS       \
      --with-newlib             \
      --without-headers         \
      --enable-default-pie      \
      --enable-default-ssp      \
      --disable-nls             \
      --disable-shared          \
      --disable-multilib        \
      --disable-threads         \
      --disable-libatomic       \
      --disable-libgomp         \
      --disable-libquadmath     \
      --disable-libssp          \
      --disable-libvtv          \
      --disable-libstdcxx       \
      --enable-languages=c,c++

  ulimit -s 32768
}

k_check() {
  :
}

k_post_install() {
  cd ..
  cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
    `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h
}
