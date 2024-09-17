#!/bin/bash

KPKG_SRC_FILE=libfm-1.3.2.tar.xz
KPKG_SRC_FOLDER=libfm-1.3.2

k_pre_configure() {
  patch -Np1 -i /alfs/patches/libfm-gtk3-1.3.2_gcc14_fixes-1.patch

  # Update xarchiver option
  # https://github.com/lxde/libfm/issues/35
  sed -i 's/create=xarchiver --add-to %F/create=xarchiver --compress %F/' data/archivers.list
  autoreconf -fi
}

k_configure() {
  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --with-gnu-ld \
      --with-gtk=3

  #https://bugzilla.gnome.org/show_bug.cgi?id=656231
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
}

k_check() {
  :
}
