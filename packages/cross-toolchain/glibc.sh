#!/bin/bash

KPKG_SRC_FILE=glibc-2.40.tar.xz
KPKG_SRC_FOLDER=glibc-2.40

k_pre_configure() {
  case $(uname -m) in
      i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
      ;;
      x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
              ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
      ;;
  esac

  patch -Np1 -i ../glibc-2.40-fhs-1.patch

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

k_pre_install() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}

k_post_install() {
  # Fix a hard coded path to the executable loader in the ldd script
  sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

  # sanity check
  echo 'int main(){}' | $LFS_TGT-gcc -xc -
  readelf -l a.out | grep ld-linux
  # [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
  rm -v a.out
}
