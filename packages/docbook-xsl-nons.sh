#!/bin/bash

KPKG_SRC_FILE=docbook-xsl-nons-1.79.2.tar.bz2
KPKG_SRC_FOLDER=docbook-xsl-nons-1.79.2

k_pre_configure() {
  patch -Np1 -i ../docbook-xsl-nons-1.79.2-stack_fix-1.patch
  tar -xf ../docbook-xsl-doc-1.79.2.tar.bz2 --strip-components=1
}

k_configure() {
  :
}

k_build() {
  :
}

k_check() {
  :
}

k_pre_install() {
  install -v -m755 -d $KPKG_TMP_DIR/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2

  cp -v -R VERSION assembly common eclipse epub epub3 extensions fo        \
          highlighting html htmlhelp images javahelp lib manpages params  \
          profiling roundtrip slides template tests tools webhelp website \
          xhtml xhtml-1_1 xhtml5                                          \
      $KPKG_TMP_DIR/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2

  ln -s VERSION $KPKG_TMP_DIR/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2/VERSION.xsl

  install -v -m644 -D README \
                      $KPKG_TMP_DIR/usr/share/doc/docbook-xsl-nons-1.79.2/README.txt
  install -v -m644    RELEASE-NOTES* NEWS* \
                      $KPKG_TMP_DIR/usr/share/doc/docbook-xsl-nons-1.79.2

  cp -v -R doc/* $KPKG_TMP_DIR/usr/share/doc/docbook-xsl-nons-1.79.2

  mkdir -pv $KPKG_TMP_DIR/etc/xml
  sed -i '/rewrite/d' $KPKG_TMP_DIR/etc/xml/catalog

  if [ ! -d $KPKG_TMP_DIR/etc/xml ]; then
      install -v -m755 -d $KPKG_TMP_DIR/etc/xml;
  fi &&
  if [ ! -f $KPKG_TMP_DIR/etc/xml/catalog ]; then
      xmlcatalog --noout --create $KPKG_TMP_DIR/etc/xml/catalog
  fi &&

  xmlcatalog --noout --add "rewriteSystem" \
            "http://cdn.docbook.org/release/xsl-nons/1.79.2" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteSystem" \
            "https://cdn.docbook.org/release/xsl-nons/1.79.2" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteURI" \
            "http://cdn.docbook.org/release/xsl-nons/1.79.2" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteURI" \
            "https://cdn.docbook.org/release/xsl-nons/1.79.2" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteSystem" \
            "http://cdn.docbook.org/release/xsl-nons/current" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteSystem" \
            "https://cdn.docbook.org/release/xsl-nons/current" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteURI" \
            "http://cdn.docbook.org/release/xsl-nons/current" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteURI" \
            "https://cdn.docbook.org/release/xsl-nons/current" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteSystem" \
            "http://docbook.sourceforge.net/release/xsl/current" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog &&

  xmlcatalog --noout --add "rewriteURI" \
            "http://docbook.sourceforge.net/release/xsl/current" \
            "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
      $KPKG_TMP_DIR/etc/xml/catalog
}
