#!/bin/bash

KPKG_SRC_FILE=tcl8.6.13-src.tar.gz
KPKG_SRC_FOLDER=tcl8.6.13

k_pre_configure() {
  SRCDIR=$(pwd)
  cd unix
}

k_configure() {
  ./configure --prefix=/usr \
              --mandir=/usr/share/man
}

k_build() {
  make

  sed -e "s|$SRCDIR/unix|/usr/lib|" \
      -e "s|$SRCDIR|/usr/include|"  \
      -i tclConfig.sh

  sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.5|/usr/lib/tdbc1.1.5|" \
      -e "s|$SRCDIR/pkgs/tdbc1.1.5/generic|/usr/include|"    \
      -e "s|$SRCDIR/pkgs/tdbc1.1.5/library|/usr/lib/tcl8.6|" \
      -e "s|$SRCDIR/pkgs/tdbc1.1.5|/usr/include|"            \
      -i pkgs/tdbc1.1.5/tdbcConfig.sh

  sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.3|/usr/lib/itcl4.2.3|" \
      -e "s|$SRCDIR/pkgs/itcl4.2.3/generic|/usr/include|"    \
      -e "s|$SRCDIR/pkgs/itcl4.2.3|/usr/include|"            \
      -i pkgs/itcl4.2.3/itclConfig.sh

  unset SRCDIR
}

k_check() {
  make test
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  chmod -v u+w $KPKG_TMP_DIR/usr/lib/libtcl8.6.so

  make DESTDIR=$KPKG_TMP_DIR install-private-headers

  ln -sfv tclsh8.6 $KPKG_TMP_DIR/usr/bin/tclsh

  mv $KPKG_TMP_DIR/usr/share/man/man3/{Thread,Tcl_Thread}.3

  # Doc
  cd ..
  tar -xf ../tcl8.6.13-html.tar.gz --strip-components=1
  mkdir -v -p $KPKG_TMP_DIR/usr/share/doc/tcl-8.6.13
  cp -v -r  ./html/* $KPKG_TMP_DIR/usr/share/doc/tcl-8.6.13
}
