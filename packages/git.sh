#!/bin/bash

KPKG_SRC_FILE=git-2.46.0.tar.xz
KPKG_SRC_FOLDER=git-2.46.0

k_configure() {
  ./configure --prefix=/usr \
              --with-gitconfig=/etc/gitconfig \
              --with-python=python3
}

k_check() {
  make test -k |& tee test.log
  grep '^not ok' test.log | grep -v TODO
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR perllibdir=/usr/lib/perl5/5.40/site_perl install

  mkdir -pv $KPKG_TMP_DIR/usr/share/man
  tar -xf ../git-manpages-2.46.0.tar.xz \
      -C $KPKG_TMP_DIR/usr/share/man --no-same-owner --no-overwrite-dir

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/git-2.46.0
  tar   -xf ../git-htmldocs-2.46.0.tar.xz \
        -C  $KPKG_TMP_DIR/usr/share/doc/git-2.46.0 --no-same-owner --no-overwrite-dir

  find      $KPKG_TMP_DIR/usr/share/doc/git-2.46.0 -type d -exec chmod 755 {} \;
  find      $KPKG_TMP_DIR/usr/share/doc/git-2.46.0 -type f -exec chmod 644 {} \;

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/man-pages/{html,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/{git*.txt,man-pages/text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/{git*.,index.,man-pages/}html

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/technical/{html,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/technical/{*.txt,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/technical/{*.,}html

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/howto/{html,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/howto/{*.txt,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/howto/{*.,}html

  sed -i '/^<a href=/s|howto/|&html/|' $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/howto-index.html
  sed -i '/^\* link:/s|howto/|&html/|' $KPKG_TMP_DIR/usr/share/doc/git-2.46.0/howto-index.txt
}
