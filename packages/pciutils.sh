#!/bin/bash

KPKG_SRC_FILE=pciutils-3.13.0.tar.gz
KPKG_SRC_FOLDER=pciutils-3.13.0

k_configure() {
  :
}

k_build() {
  make PREFIX=/usr                \
       SHAREDIR=/usr/share/hwdata \
       SHARED=yes
}

k_check() {
  :
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR      \
     PREFIX=/usr                \
     SHAREDIR=/usr/share/hwdata \
     SHARED=yes                 \
     install install-lib

chmod -v 755 $KPKG_TMP_DIR/usr/lib/libpci.so

cat > $KPKG_TMP_DIR/etc/cron.weekly/update-pciids.sh << "EOF" &&
#!/bin/bash
/usr/sbin/update-pciids
EOF
chmod 754 $KPKG_TMP_DIR/etc/cron.weekly/update-pciids.sh
}

k_post_install() {
  update-pciids
  # /usr/share/hwdata/pci.ids.gz.new
}
