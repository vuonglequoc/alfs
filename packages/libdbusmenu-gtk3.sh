#!/bin/bash

KPKG_SRC_FILE=
KPKG_SRC_FOLDER=libdbusmenu-gtk3-16.04.0

k_prepare_source() {
  cd $KPKG_ROOT/sources
  git clone https://github.com/AyatanaIndicators/libdbusmenu.git
  mv libdbusmenu $KPKG_SRC_FOLDER
  cd $KPKG_SRC_FOLDER
  patch -Np1 -i /alfs/patches/libdbusmenu-gtk3-16.04.0-compatible_fixes-1.patch
}

k_configure() {
  NOCONFIGURE=1 ./autogen.sh
  ./configure --prefix=/usr \
                          --sysconfdir=/etc \
                          --localstatedir=/var \
                          --with-gtk=3 \
                          --enable-gtk-doc \
                          --disable-dumper
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
}

k_check() {
  :
}
