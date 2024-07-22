#!/bin/bash

KPKG_SRC_FILE=p11-kit-0.25.5.tar.xz
KPKG_SRC_FOLDER=p11-kit-0.25.5

k_pre_configure() {
sed '20,$ d' -i trust/trust-extract-compat

cat >> trust/trust-extract-compat << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Update trust stores
/usr/sbin/make-ca -r
EOF

mkdir p11-build
cd    p11-build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -Dtrust_paths=/etc/pki/anchors
}

k_build() {
  ninja
}

k_check() {
  LC_ALL=C ninja test
}

k_install() {
  ninja install
  ln -sfv /usr/libexec/p11-kit/trust-extract-compat \
          /usr/bin/update-ca-certificates
}

k_post_install() {
  ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  ln -sfv $KPKG_TMP_DIR/usr/libexec/p11-kit/trust-extract-compat \
          $KPKG_TMP_DIR/usr/bin/update-ca-certificates
  ln -sfv ./pkcs11/p11-kit-trust.so $KPKG_TMP_DIR/usr/lib/libnssckbi.so
}
