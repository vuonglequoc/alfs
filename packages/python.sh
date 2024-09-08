#!/bin/bash

KPKG_SRC_FILE=Python-3.12.2.tar.xz
KPKG_SRC_FOLDER=Python-3.12.2

k_configure() {
  ./configure --prefix=/usr       \
              --enable-shared     \
              --with-system-expat \
              --enable-optimizations
}

k_check() {
  :
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR install

cat > $KPKG_TMP_DIR/etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF

install -v -dm755 $KPKG_TMP_DIR/usr/share/doc/python-3.12.2/html

tar --no-same-owner \
    -xvf ../python-3.12.2-docs-html.tar.bz2
cp -R --no-preserve=mode python-3.12.2-docs-html/* \
    $KPKG_TMP_DIR/usr/share/doc/python-3.12.2/html
}
