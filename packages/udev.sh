#!/bin/bash

KPKG_SRC_FILE=systemd-256.4.tar.gz
KPKG_SRC_FOLDER=systemd-256.4

k_pre_configure() {
  sed -i -e 's/GROUP="render"/GROUP="video"/' \
        -e 's/GROUP="sgx", //' rules.d/50-udev-default.rules.in

  sed '/systemd-sysctl/s/^/#/' -i rules.d/99-systemd.rules.in

  sed '/NETWORK_DIRS/s/systemd/udev/' -i src/basic/path-lookup.h

  mkdir -p build
  cd       build
}

k_configure() {
  meson setup ..                  \
        --prefix=/usr             \
        --buildtype=release       \
        -D mode=release           \
        -D dev-kvm-mode=0660      \
        -D link-udev-shared=false \
        -D logind=false           \
        -D vconsole=false

  export udev_helpers=$(grep "'name' :" ../src/udev/meson.build | \
                        awk '{print $3}' | tr -d ",'" | grep -v 'udevadm')
}

k_build() {
  ninja udevadm systemd-hwdb                                           \
        $(ninja -n | grep -Eo '(src/(lib)?udev|rules.d|hwdb.d)/[^ ]*') \
        $(realpath libudev.so --relative-to .)                         \
        $udev_helpers
}

k_check() {
  :
}

k_pre_install() {
  install -vm755 -d $KPKG_TMP_DIR/usr/{bin,sbin,include}
  install -vm755 -d $KPKG_TMP_DIR/usr/share/man/{man5,man8}
  install -vm755 -d {$KPKG_TMP_DIR/usr/lib,$KPKG_TMP_DIR/etc}/udev/{hwdb.d,rules.d,network}
  install -vm755 -d $KPKG_TMP_DIR/usr/{lib,share}/pkgconfig
  install -vm755 udevadm                             $KPKG_TMP_DIR/usr/bin/
  install -vm755 systemd-hwdb                        $KPKG_TMP_DIR/usr/bin/udev-hwdb
  ln      -svfn  ../bin/udevadm                      $KPKG_TMP_DIR/usr/sbin/udevd
  cp      -av    libudev.so{,*[0-9]}                 $KPKG_TMP_DIR/usr/lib/
  install -vm644 ../src/libudev/libudev.h            $KPKG_TMP_DIR/usr/include/
  install -vm644 src/libudev/*.pc                    $KPKG_TMP_DIR/usr/lib/pkgconfig/
  install -vm644 src/udev/*.pc                       $KPKG_TMP_DIR/usr/share/pkgconfig/
  install -vm644 ../src/udev/udev.conf               $KPKG_TMP_DIR/etc/udev/
  install -vm644 rules.d/* ../rules.d/README         $KPKG_TMP_DIR/usr/lib/udev/rules.d/
  install -vm644 $(find ../rules.d/*.rules \
                        -not -name '*power-switch*') $KPKG_TMP_DIR/usr/lib/udev/rules.d/
  install -vm644 hwdb.d/*  ../hwdb.d/{*.hwdb,README} $KPKG_TMP_DIR/usr/lib/udev/hwdb.d/
  install -vm755 $udev_helpers                       $KPKG_TMP_DIR/usr/lib/udev
  install -vm644 ../network/99-default.link          $KPKG_TMP_DIR/usr/lib/udev/network

  # Install some custom rules and support files useful in an LFS environment
  tar -xvf ../../udev-lfs-20230818.tar.xz
  make DESTDIR=$KPKG_TMP_DIR -f udev-lfs-20230818/Makefile.lfs install

  # Install the man pages
  tar -xf $KPKG_ROOT/sources/systemd-man-pages-256.4.tar.xz \
      --no-same-owner --strip-components=1                  \
      -C $KPKG_TMP_DIR/usr/share/man                        \
      --wildcards '*/udev*' '*/libudev*'                    \
                  '*/systemd.link.5'                        \
                  '*/systemd-'{hwdb,udevd.service}.8

  sed 's|systemd/network|udev/network|'             \
      $KPKG_TMP_DIR/usr/share/man/man5/systemd.link.5            \
    > $KPKG_TMP_DIR/usr/share/man/man5/udev.link.5

  sed 's/systemd\(\\\?-\)/udev\1/'                  \
      $KPKG_TMP_DIR/usr/share/man/man8/systemd-hwdb.8            \
    > $KPKG_TMP_DIR/usr/share/man/man8/udev-hwdb.8

  sed 's|lib.*udevd|sbin/udevd|'                    \
      $KPKG_TMP_DIR/usr/share/man/man8/systemd-udevd.service.8   \
    > $KPKG_TMP_DIR/usr/share/man/man8/udevd.8

  rm $KPKG_TMP_DIR/usr/share/man/man*/systemd*

  unset udev_helpers
}

k_post_install() {
  # Configuring Udev
  udev-hwdb update
}
