#!/bin/bash

KPKG_SRC_FILE=ffmpeg-7.0.1.tar.xz
KPKG_SRC_FOLDER=ffmpeg-7.0.1

k_pre_configure() {
  patch -Np1 -i ../ffmpeg-7.0.1-chromium_method-1.patch
}

k_configure() {
  ./configure --prefix=/usr        \
              --enable-gpl         \
              --enable-version3    \
              --enable-nonfree     \
              --disable-static     \
              --enable-shared      \
              --disable-debug      \
              --enable-libaom      \
              --enable-libass      \
              --enable-libfdk-aac  \
              --enable-libfreetype \
              --enable-libmp3lame  \
              --enable-libopus     \
              --enable-libvorbis   \
              --enable-libvpx      \
              --enable-libx264     \
              --enable-libx265     \
              --enable-openssl     \
              --ignore-tests=enhanced-flv-av1 \
              --docdir=/usr/share/doc/ffmpeg-7.0.1
}

k_build() {
  make
  gcc tools/qt-faststart.c -o tools/qt-faststart
}

k_check() {
  :
}

k_install() {
  make install

  install -v -m755    tools/qt-faststart /usr/bin
  install -v -m755 -d           /usr/share/doc/ffmpeg-7.0.1
  install -v -m644    doc/*.txt /usr/share/doc/ffmpeg-7.0.1
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m755    tools/qt-faststart $KPKG_TMP_DIR/usr/bin
  install -v -m755 -d           $KPKG_TMP_DIR/usr/share/doc/ffmpeg-7.0.1
  install -v -m644    doc/*.txt $KPKG_TMP_DIR/usr/share/doc/ffmpeg-7.0.1
}
