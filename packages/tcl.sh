#!/bin/bash

KPKG_SRC_FILE=tcl8.6.14-src.tar.gz
KPKG_SRC_FOLDER=tcl8.6.14

k_pre_configure() {
  SRCDIR=$(pwd)
  cd unix
}

k_configure() {
  ./configure --prefix=/usr           \
              --mandir=/usr/share/man \
              --disable-rpath
}

k_build() {
  make

  sed -e "s|$SRCDIR/unix|/usr/lib|" \
      -e "s|$SRCDIR|/usr/include|"  \
      -i tclConfig.sh

  sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.7|/usr/lib/tdbc1.1.7|" \
      -e "s|$SRCDIR/pkgs/tdbc1.1.7/generic|/usr/include|"    \
      -e "s|$SRCDIR/pkgs/tdbc1.1.7/library|/usr/lib/tcl8.6|" \
      -e "s|$SRCDIR/pkgs/tdbc1.1.7|/usr/include|"            \
      -i pkgs/tdbc1.1.7/tdbcConfig.sh

  sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.4|/usr/lib/itcl4.2.4|" \
      -e "s|$SRCDIR/pkgs/itcl4.2.4/generic|/usr/include|"    \
      -e "s|$SRCDIR/pkgs/itcl4.2.4|/usr/include|"            \
      -i pkgs/itcl4.2.4/itclConfig.sh

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

  # Rename a man page that conflicts with a Perl man page
  mv $KPKG_TMP_DIR/usr/share/man/man3/{Thread,Tcl_Thread}.3

  # Doc
  cd ..
  tar -xf ../tcl8.6.14-html.tar.gz --strip-components=1
  mkdir -v -p $KPKG_TMP_DIR/usr/share/doc/tcl-8.6.14
  cp -v -r  ./html/* $KPKG_TMP_DIR/usr/share/doc/tcl-8.6.14
}
