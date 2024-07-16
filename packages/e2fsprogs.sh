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

k_post_install() {
  rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

  gunzip -v /usr/share/info/libext2fs.info.gz
  install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

  makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
  install -v -m644 doc/com_err.info /usr/share/info
  install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info

  sed 's/metadata_csum_seed,//' -i /etc/mke2fs.conf
}
