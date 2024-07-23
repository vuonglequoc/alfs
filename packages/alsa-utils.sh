#!/bin/bash

KPKG_SRC_FILE=alsa-utils-1.2.12.tar.bz2
KPKG_SRC_FOLDER=alsa-utils-1.2.12

k_configure() {
  ./configure --disable-alsaconf \
              --disable-bat      \
              --disable-xmlto    \
              --with-curses=ncursesw
}

k_check() {
  make check
}

k_post_install() {
alsactl init
alsactl -L store

cat /proc/asound/cards

cat > /etc/asound.conf << "EOF"
# Begin /etc/asound.conf

defaults.pcm.card 0
defaults.ctl.card 0

# End /etc/asound.conf
EOF

# add us to audio group to access audio cards
gpasswd -a user audio
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install
  cp /etc/asound.conf $KPKG_TMP_DIR/etc/asound.conf
}
