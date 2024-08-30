#!/bin/bash

# Browser
#     brotli-1.1.0
#     c-ares
#     nghttp2
#   Node
#   libwebp
#   libXcomposite
#   libXcursor
#   libXdamage
#   xorg-macros
#   libice
#   libsm
#   libnotify
# Firefox

# File Manager
#   libfm-extra
#   menu-cache
#   libfm-gtk3
# pcmanfm-gtk3

source /alfs/kpkg/kpkg.sh

export XORG_PREFIX=/usr
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static"
export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig"

# firefox #
kpkg_install /alfs packages brotli
kpkg_install /alfs packages c-ares
kpkg_install /alfs packages nghttp2
kpkg_install /alfs packages nodejs
kpkg_install /alfs packages libwebp
kpkg_install /alfs packages xorg-lib/libXcomposite
kpkg_install /alfs packages xorg-lib/libXcursor
kpkg_install /alfs packages xorg-lib/libXdamage
kpkg_install /alfs packages xorg-lib/libICE
kpkg_install /alfs packages xorg-lib/libSM
kpkg_install /alfs packages libnotify
kpkg_install /alfs packages firefox

# pcmanfm-gtk3 #
kpkg_install /alfs packages libfm-extra
kpkg_install /alfs packages menu-cache
kpkg_install /alfs packages libfm-gtk3
kpkg_install /alfs packages pcmanfm-gtk3
