#!/bin/bash

KPKG_SRC_FILE=glibc-2.39.tar.xz
KPKG_SRC_FOLDER=glibc-2.39

k_pre_configure() {
  case $(uname -m) in
      i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
      ;;
      x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
              ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
      ;;
  esac

  patch -Np1 -i ../glibc-2.39-fhs-1.patch

  mkdir -v build
  cd       build

  echo "rootsbindir=/usr/sbin" > configparms
}

k_configure() {
  ../configure                             \
        --prefix=/usr                      \
        --host=$LFS_TGT                    \
        --build=$(../scripts/config.guess) \
        --enable-kernel=4.19               \
        --with-headers=$LFS/usr/include    \
        --disable-nscd                     \
        libc_cv_slibdir=/usr/lib
}

k_check() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}

k_post_install() {
  sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
}
