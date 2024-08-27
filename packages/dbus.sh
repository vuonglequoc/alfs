#!/bin/bash

KPKG_SRC_FILE=dbus-1.14.10.tar.xz
KPKG_SRC_FOLDER=dbus-1.14.10

k_configure() {
  ./configure --prefix=/usr                        \
              --sysconfdir=/etc                    \
              --localstatedir=/var                 \
              --runstatedir=/run                   \
              --disable-doxygen-docs               \
              --disable-xml-docs                   \
              --disable-static                     \
              --with-systemduserunitdir=no         \
              --with-systemdsystemunitdir=no       \
              --docdir=/usr/share/doc/dbus-1.14.10  \
              --with-system-socket=/run/dbus/system_bus_socket
}

k_check() {
  make test
}

k_post_install() {
  chown -v root:messagebus /usr/libexec/dbus-daemon-launch-helper
  chmod -v      4750       /usr/libexec/dbus-daemon-launch-helper

  dbus-uuidgen --ensure

cat > /etc/dbus-1/session-local.conf << "EOF"
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
EOF

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make install-dbus
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416

  /etc/init.d/dbus start

cat >> /home/user/.bash_logout << "EOF"
# Kill the D-Bus session daemon
kill $DBUS_SESSION_BUS_PID
EOF
}

k_pre_record() {
  cd $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  make DESTDIR=$KPKG_TMP_DIR install

  cp /etc/dbus-1/session-local.conf $KPKG_TMP_DIR/etc/dbus-1/session-local.conf

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-dbus
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
