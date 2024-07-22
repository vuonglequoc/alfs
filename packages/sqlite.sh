#!/bin/bash

KPKG_SRC_FILE=sqlite-autoconf-3460000.tar.gz
KPKG_SRC_FOLDER=sqlite-autoconf-3460000

k_pre_configure() {
  unzip -q ../sqlite-doc-3460000.zip
}

k_configure() {
  ./configure --prefix=/usr     \
              --disable-static  \
              --enable-fts{4,5} \
              CPPFLAGS="-DSQLITE_ENABLE_COLUMN_METADATA=1 \
                        -DSQLITE_ENABLE_UNLOCK_NOTIFY=1   \
                        -DSQLITE_ENABLE_DBSTAT_VTAB=1     \
                        -DSQLITE_SECURE_DELETE=1          \
                        -DSQLITE_ENABLE_FTS3_TOKENIZER=1"
}

k_check() {
  :
}

k_install() {
  make install

  install -v -m755 -d /usr/share/doc/sqlite-3.46.0
  cp -v -R sqlite-doc-3460000/* /usr/share/doc/sqlite-3.46.0
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m755 -d $KPKG_TMP_DIR/usr/share/doc/sqlite-3.46.0
  cp -v -R sqlite-doc-3460000/* $KPKG_TMP_DIR/usr/share/doc/sqlite-3.46.0
}
