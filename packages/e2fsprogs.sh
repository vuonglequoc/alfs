#!/bin/bash

KPKG_SRC_FILE=e2fsprogs-1.47.0.tar.gz
KPKG_SRC_FOLDER=e2fsprogs-1.47.0

k_pre_configure() {
  mkdir -v build
  cd       build
}

k_configure() {
  ../configure --prefix=/usr       \
               --sysconfdir=/etc   \
               --enable-elf-shlibs \
               --disable-libblkid  \
               --disable-libuuid   \
               --disable-uuidd     \
               --disable-fsck
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  rm -fv $KPKG_TMP_DIR/usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

  gunzip -v $KPKG_TMP_DIR/usr/share/info/libext2fs.info.gz
  install-info --dir-file=$KPKG_TMP_DIR/usr/share/info/dir $KPKG_TMP_DIR/usr/share/info/libext2fs.info

  makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
  install -v -m644 doc/com_err.info $KPKG_TMP_DIR/usr/share/info
  install-info --dir-file=$KPKG_TMP_DIR/usr/share/info/dir $KPKG_TMP_DIR/usr/share/info/com_err.info

  sed 's/metadata_csum_seed,//' -i $KPKG_TMP_DIR/etc/mke2fs.conf
}
