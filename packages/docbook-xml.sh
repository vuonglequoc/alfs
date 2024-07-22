#!/bin/bash

KPKG_SRC_FILE=docbook-v5.1-os.zip
KPKG_SRC_FOLDER=docbook-v5.1-os

k_pre_configure() {
  mkdir $KPKG_SRC_FOLDER
  cd $KPKG_SRC_FOLDER
  unzip ../$KPKG_SRC_FILE
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

k_install() {
  install -vdm755 /usr/share/xml/docbook/schema/{rng,sch}/5.1
  install -m644   schemas/rng/* /usr/share/xml/docbook/schema/rng/5.1
  install -m644   schemas/sch/* /usr/share/xml/docbook/schema/sch/5.1
  install -m755   tools/db4-entities.pl /usr/bin
  install -vdm755 /usr/share/xml/docbook/stylesheet/docbook5
  install -m644   tools/db4-upgrade.xsl \
                  /usr/share/xml/docbook/stylesheet/docbook5

  mkdir /etc/xml
  if [ ! -e /etc/xml/docbook-5.1 ]; then
    xmlcatalog --noout --create /etc/xml/docbook-5.1
  fi

  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/rng/docbook.rng" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbook.rng" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/rng/docbook.rng" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbook.rng" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/rng/docbookxi.rng" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbookxi.rng" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/rng/docbookxi.rng" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbookxi.rng" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/rnc/docbook.rnc" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbook.rnc" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/rng/docbook.rnc" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbook.rnc" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/rnc/docbookxi.rnc" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbookxi.rnc" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/rng/docbookxi.rnc" \
    "file:///usr/share/xml/docbook/schema/rng/5.1/docbookxi.rnc" \
    /etc/xml/docbook-5.1 &&

  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/sch/docbook.sch" \
    "file:///usr/share/xml/docbook/schema/sch/5.1/docbook.sch" \
    /etc/xml/docbook-5.1 &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/sch/docbook.sch" \
    "file:///usr/share/xml/docbook/schema/sch/5.1/docbook.sch" \
    /etc/xml/docbook-5.1

  xmlcatalog --noout --create /usr/share/xml/docbook/schema/rng/5.1/catalog.xml

  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/schemas/rng/docbook.schemas/rng" \
    "docbook.schemas/rng" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/schemas/rng/docbook.schemas/rng" \
    "docbook.schemas/rng" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/schemas/rng/docbookxi.schemas/rng" \
    "docbookxi.schemas/rng" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/schemas/rng/docbookxi.schemas/rng" \
    "docbookxi.schemas/rng" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/schemas/rng/docbook.rnc" \
    "docbook.rnc" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/schemas/rng/docbook.rnc" \
    "docbook.rnc" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/schemas/rng/docbookxi.rnc" \
    "docbookxi.rnc" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/schemas/rng/docbookxi.rnc" \
    "docbookxi.rnc" /usr/share/xml/docbook/schema/rng/5.1/catalog.xml

  xmlcatalog --noout --create /usr/share/xml/docbook/schema/sch/5.1/catalog.xml

  xmlcatalog --noout --add "uri" \
    "http://docbook.org/xml/5.1/schemas/sch/docbook.schemas/sch" \
    "docbook.schemas/sch" /usr/share/xml/docbook/schema/sch/5.1/catalog.xml &&
  xmlcatalog --noout --add "uri" \
    "http://www.oasis-open.org/docbook/xml/5.1/schemas/sch/docbook.schemas/sch" \
    "docbook.schemas/sch" /usr/share/xml/docbook/schema/sch/5.1/catalog.xml

  if [ ! -e /etc/xml/catalog ]; then
    xmlcatalog --noout --create /etc/xml/catalog
  fi

  xmlcatalog --noout --add "delegatePublic" \
    "-//OASIS//DTD DocBook XML 5.1//EN" \
    "file:///usr/share/xml/docbook/schema/dtd/5.1/catalog.xml" \
    /etc/xml/catalog &&
  xmlcatalog --noout --add "delegateSystem" \
    "http://docbook.org/xml/5.1/dtd/" \
    "file:///usr/share/xml/docbook/schema/dtd/5.1/catalog.xml" \
    /etc/xml/catalog &&
  xmlcatalog --noout --add "delegateURI" \
    "http://docbook.org/xml/5.1/dtd/" \
    "file:///usr/share/xml/docbook/schema/dtd/5.1/catalog.xml" \
    /etc/xml/catalog &&
  xmlcatalog --noout --add "delegateURI" \
    "http://docbook.org/xml/5.1/rng/"  \
    "file:///usr/share/xml/docbook/schema/rng/5.1/catalog.xml" \
    /etc/xml/catalog &&
  xmlcatalog --noout --add "delegateURI" \
    "http://docbook.org/xml/5.1/sch/"  \
    "file:///usr/share/xml/docbook/schema/sch/5.1/catalog.xml" \
    /etc/xml/catalog &&
  xmlcatalog --noout --add "delegateURI" \
    "http://docbook.org/xml/5.1/xsd/"  \
    "file:///usr/share/xml/docbook/schema/xsd/5.1/catalog.xml" \
    /etc/xml/catalog
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR docdir=/usr/share/doc install
  install -vdm755 $KPKG_TMP_DIR/usr/share/xml/docbook/schema/{rng,sch}/5.1
  install -m644   schemas/rng/* $KPKG_TMP_DIR/usr/share/xml/docbook/schema/rng/5.1
  install -m644   schemas/sch/* $KPKG_TMP_DIR/usr/share/xml/docbook/schema/sch/5.1
  install -m755   tools/db4-entities.pl $KPKG_TMP_DIR/usr/bin
  install -vdm755 $KPKG_TMP_DIR/usr/share/xml/docbook/stylesheet/docbook5
  install -m644   tools/db4-upgrade.xsl \
                  $KPKG_TMP_DIR/usr/share/xml/docbook/stylesheet/docbook5

  mkdir -p $KPKG_TMP_DIR/etc/xml
  mkdir -p $KPKG_TMP_DIR/usr/share/xml/docbook/schema/rng/5.1
  mkdir -p $KPKG_TMP_DIR/usr/share/xml/docbook/schema/sch/5.1
  cp /etc/xml/docbook-5.1 $KPKG_TMP_DIR/etc/xml/docbook-5.1
  cp /usr/share/xml/docbook/schema/rng/5.1/catalog.xml $KPKG_TMP_DIR/usr/share/xml/docbook/schema/rng/5.1/catalog.xml
  cp /usr/share/xml/docbook/schema/sch/5.1/catalog.xml $KPKG_TMP_DIR/usr/share/xml/docbook/schema/sch/5.1/catalog.xml
  cp /etc/xml/catalog $KPKG_TMP_DIR/etc/xml/catalog
}
