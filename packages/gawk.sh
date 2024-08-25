#!/bin/bash

KPKG_SRC_FILE=gawk-5.3.0.tar.xz
KPKG_SRC_FOLDER=gawk-5.3.0

k_pre_configure() {
  sed -i 's/extras//' Makefile.in
}

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  chown -Rv tester .
  su tester -c "PATH=$PATH make check"
}

k_install() {
  rm -f /usr/bin/gawk-5.3.0
  make install
}

k_post_install() {
  ln -sv gawk.1 /usr/share/man/man1/awk.1

  mkdir -pv                                   /usr/share/doc/gawk-5.3.0
  cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.3.0
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  ln -sv gawk.1 $KPKG_TMP_DIR/usr/share/man/man1/awk.1

  mkdir -pv                                   $KPKG_TMP_DIR/usr/share/doc/gawk-5.3.0
  cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} $KPKG_TMP_DIR/usr/share/doc/gawk-5.3.0
}
