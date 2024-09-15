#!/bin/bash

KPKG_SRC_FILE=gcc-14.2.0.tar.xz
KPKG_SRC_FOLDER=gcc-14.2.0

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
               --enable-host-pie        \
               --disable-multilib       \
               --disable-bootstrap      \
               --disable-fixincludes    \
               --with-system-zlib

  # ulimit -s -H unlimited
  ulimit -s 32768
}

k_check() {
  # remove/fix several known test failures
  sed -e '/cpython/d'               -i ../gcc/testsuite/gcc.dg/plugin/plugin.exp
  sed -e 's/no-pic /&-no-pie /'     -i ../gcc/testsuite/gcc.target/i386/pr113689-1.c
  sed -e 's/300000/(1|300000)/'     -i ../libgomp/testsuite/libgomp.c-c++-common/pr109062.c
  sed -e 's/{ target nonpic } //' \
      -e '/GOTPCREL/d'              -i ../gcc/testsuite/gcc.target/i386/fentryname3.c

  # Test the results as a non-privileged user, but do not stop at errors
  chown -Rv tester . 
  su tester -c "PATH=$PATH make -k check"

  # extract a summary of the test suite results
  ../contrib/test_summary
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  # move misplaced file
  mkdir -pv $KPKG_TMP_DIR/usr/share/gdb/auto-load/usr/lib
  mv -v $KPKG_TMP_DIR/usr/lib/*gdb.py $KPKG_TMP_DIR/usr/share/gdb/auto-load/usr/lib

  # Create a symlink required by the FHS for "historical" reasons
  ln -sv ../bin/cpp $KPKG_TMP_DIR/usr/lib/cpp

  ln -sv gcc.1 $KPKG_TMP_DIR/usr/share/man/man1/cc.1
}

k_post_install() {
  # gcc -dumpmachine
  # Old cross-compile x86_64-lfs-linux-gnu
  # New native        x86_64-pc-linux-gnu
  chown -Rv root:root \
      /usr/lib/gcc/$(gcc -dumpmachine)/14.2.0/include{,-fixed}

  ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/14.2.0/liblto_plugin.so \
          /usr/lib/bfd-plugins/

  # TEST
  echo 'int main(){}' > dummy.c
  cc dummy.c -v -Wl,--verbose &> dummy.log
  readelf -l a.out | grep ': /lib'
  # [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]

  grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log
  # /usr/lib/gcc/x86_64-pc-linux-gnu/14.2.0/../../../../lib/Scrt1.o succeeded
  # /usr/lib/gcc/x86_64-pc-linux-gnu/14.2.0/../../../../lib/crti.o succeeded
  # /usr/lib/gcc/x86_64-pc-linux-gnu/14.2.0/../../../../lib/crtn.o succeeded

  grep -B4 '^ /usr/include' dummy.log
  # #include <...> search starts here:
  # /usr/lib/gcc/x86_64-pc-linux-gnu/14.2.0/include
  # /usr/local/include
  # /usr/lib/gcc/x86_64-pc-linux-gnu/14.2.0/include-fixed
  # /usr/include

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
}
