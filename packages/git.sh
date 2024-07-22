#!/bin/bash

KPKG_SRC_FILE=git-2.45.2.tar.xz
KPKG_SRC_FOLDER=git-2.45.2

k_configure() {
  ./configure --prefix=/usr \
              --with-gitconfig=/etc/gitconfig \
              --with-python=python3
}

k_check() {
  make test -k |& tee test.log
  grep '^not ok' test.log | grep -v TODO
}

k_install() {
  make perllibdir=/usr/lib/perl5/5.38/site_perl install
}

k_post_install() {
  tar -xf ../git-manpages-2.45.2.tar.xz \
      -C /usr/share/man --no-same-owner --no-overwrite-dir

  mkdir -vp   /usr/share/doc/git-2.45.2
  tar   -xf   ../git-htmldocs-2.45.2.tar.xz \
        -C    /usr/share/doc/git-2.45.2 --no-same-owner --no-overwrite-dir

  find        /usr/share/doc/git-2.45.2 -type d -exec chmod 755 {} \;
  find        /usr/share/doc/git-2.45.2 -type f -exec chmod 644 {} \;

  mkdir -vp /usr/share/doc/git-2.45.2/man-pages/{html,text}
  mv        /usr/share/doc/git-2.45.2/{git*.txt,man-pages/text}
  mv        /usr/share/doc/git-2.45.2/{git*.,index.,man-pages/}html

  mkdir -vp /usr/share/doc/git-2.45.2/technical/{html,text}
  mv        /usr/share/doc/git-2.45.2/technical/{*.txt,text}
  mv        /usr/share/doc/git-2.45.2/technical/{*.,}html

  mkdir -vp /usr/share/doc/git-2.45.2/howto/{html,text}
  mv        /usr/share/doc/git-2.45.2/howto/{*.txt,text}
  mv        /usr/share/doc/git-2.45.2/howto/{*.,}html

  sed -i '/^<a href=/s|howto/|&html/|' /usr/share/doc/git-2.45.2/howto-index.html
  sed -i '/^\* link:/s|howto/|&html/|' /usr/share/doc/git-2.45.2/howto-index.txt
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR perllibdir=/usr/lib/perl5/5.38/site_perl install

  tar -xf ../git-manpages-2.45.2.tar.xz \
      -C $KPKG_TMP_DIR/usr/share/man --no-same-owner --no-overwrite-dir

  mkdir -vp   $KPKG_TMP_DIR/usr/share/doc/git-2.45.2
  tar   -xf   ../git-htmldocs-2.45.2.tar.xz \
        -C    $KPKG_TMP_DIR/usr/share/doc/git-2.45.2 --no-same-owner --no-overwrite-dir

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/man-pages/{html,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/{git*.txt,man-pages/text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/{git*.,index.,man-pages/}html

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/technical/{html,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/technical/{*.txt,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/technical/{*.,}html

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/howto/{html,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/howto/{*.txt,text}
  mv        $KPKG_TMP_DIR/usr/share/doc/git-2.45.2/howto/{*.,}html
}
