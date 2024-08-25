#!/bin/bash

KPKG_SRC_FILE=gcc-13.2.0.tar.xz
KPKG_SRC_FOLDER=gcc-13.2.0

k_pre_configure() {
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
  ../configure --prefix=/usr            \
              LD=ld                    \
              --enable-languages=c,c++ \
              --enable-default-pie     \
              --enable-default-ssp     \
              --disable-multilib       \
              --disable-bootstrap      \
              --disable-fixincludes    \
              --with-system-zlib

  ulimit -s 32768
}

k_check() {
  chown -Rv tester . 
  su tester -c "PATH=$PATH make -k check"
  ../contrib/test_summary
}

k_post_install() {
  chown -Rv root:root \
      /usr/lib/gcc/$(gcc -dumpmachine)/13.2.0/include{,-fixed}

  ln -svr /usr/bin/cpp /usr/lib

  ln -sv gcc.1 /usr/share/man/man1/cc.1

  ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/13.2.0/liblto_plugin.so \
          /usr/lib/bfd-plugins/

  # TEST
  echo 'int main(){}' > dummy.c
  cc dummy.c -v -Wl,--verbose &> dummy.log
  readelf -l a.out | grep ': /lib'
  # [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]

  grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log
  # /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/../../../../lib/Scrt1.o succeeded
  # /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/../../../../lib/crti.o succeeded
  # /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/../../../../lib/crtn.o succeeded

  grep -B4 '^ /usr/include' dummy.log
  # #include <...> search starts here:
  #  /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/include
  #  /usr/local/include
  #  /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/include-fixed
  #  /usr/include

  grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
  # SEARCH_DIR("/usr/x86_64-pc-linux-gnu/lib64")
  # SEARCH_DIR("/usr/local/lib64")
  # SEARCH_DIR("/lib64")
  # SEARCH_DIR("/usr/lib64")
  # SEARCH_DIR("/usr/x86_64-pc-linux-gnu/lib")
  # SEARCH_DIR("/usr/local/lib")
  # SEARCH_DIR("/lib")
  # SEARCH_DIR("/usr/lib");

  grep "/lib.*/libc.so.6 " dummy.log
  # attempt to open /usr/lib/libc.so.6 succeeded

  grep found dummy.log
  # found ld-linux-x86-64.so.2 at /usr/lib/ld-linux-x86-64.so.2

  rm -v dummy.c a.out dummy.log

  # move misplaced file
  mkdir -pv /usr/share/gdb/auto-load/usr/lib
  mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
}
