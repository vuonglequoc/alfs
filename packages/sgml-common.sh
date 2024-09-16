#!/bin/bash

KPKG_SRC_FILE=sgml-common-0.6.3.tgz
KPKG_SRC_FOLDER=sgml-common-0.6.3

k_pre_configure() {
  patch -Np1 -i ../sgml-common-0.6.3-manpage-1.patch
  autoreconf -f -i
}

k_configure() {
  ./configure --prefix=/usr --sysconfdir=/etc
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR docdir=/usr/share/doc install
}

k_post_install() {
  install-catalog --add /etc/sgml/sgml-ent.cat \
      /usr/share/sgml/sgml-iso-entities-8879.1986/catalog

  install-catalog --add /etc/sgml/sgml-docbook.cat \
      /etc/sgml/sgml-ent.cat
}
