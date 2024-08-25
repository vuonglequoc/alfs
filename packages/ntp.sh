#!/bin/bash

KPKG_SRC_FILE=ntp-4.2.8p18.tar.gz
KPKG_SRC_FOLDER=ntp-4.2.8p18

k_pre_configure() {
  groupadd -g 87 ntp
  useradd -c "Network Time Protocol" -d /var/lib/ntp -u 87 \
          -g ntp -s /bin/false ntp
}

k_configure() {
  ./configure --prefix=/usr         \
              --bindir=/usr/sbin    \
              --sysconfdir=/etc     \
              --enable-linuxcaps    \
              --with-lineeditlibs=readline \
              --docdir=/usr/share/doc/ntp-4.2.8p18
}

k_install() {
  make install
  install -v -o ntp -g ntp -d /var/lib/ntp
}

k_post_install() {
cat > /etc/ntp.conf << "EOF"
# Asia
server 0.asia.pool.ntp.org

# Australia
server 0.oceania.pool.ntp.org

# Europe
server 0.europe.pool.ntp.org

# North America
server 0.north-america.pool.ntp.org

# South America
server 2.south-america.pool.ntp.org

driftfile /var/lib/ntp/ntp.drift
pidfile   /run/ntpd.pid
EOF

cat >> /etc/ntp.conf << "EOF"
# Security session
restrict    default limited kod nomodify notrap nopeer noquery
restrict -6 default limited kod nomodify notrap nopeer noquery

restrict 127.0.0.1
restrict ::1
EOF

ln -v -sf ../init.d/setclock /etc/rc.d/rc0.d/K46setclock
ln -v -sf ../init.d/setclock /etc/rc.d/rc6.d/K46setclock

echo "Please add the following command to root's crontab: ntpd -q with fcrontab -e"
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install
  install -v -o ntp -g ntp -d $KPKG_TMP_DIR/var/lib/ntp
  cp /etc/ntp.conf $KPKG_TMP_DIR/etc/ntp.conf
}
