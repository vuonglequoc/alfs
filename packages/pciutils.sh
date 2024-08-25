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

k_install() {
  make PREFIX=/usr                \
       SHAREDIR=/usr/share/hwdata \
       SHARED=yes                 \
       install install-lib
}

k_post_install() {
chmod -v 755 /usr/lib/libpci.so

update-pciids
# /usr/share/hwdata/pci.ids.gz.new

cat > /etc/cron.weekly/update-pciids.sh << "EOF" &&
#!/bin/bash
/usr/sbin/update-pciids
EOF
chmod 754 /etc/cron.weekly/update-pciids.sh
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR      \
       PREFIX=/usr                \
       SHAREDIR=/usr/share/hwdata \
       SHARED=yes                 \
       install install-lib

  cp /usr/share/hwdata/pci.ids.gz.new $KPKG_TMP_DIR/usr/share/hwdata/pci.ids.gz.new
  cp /etc/cron.weekly/update-pciids.sh $KPKG_TMP_DIR/etc/cron.weekly/update-pciids.sh
}
