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
kpkg_install brotli
kpkg_install c-ares
kpkg_install nghttp2
kpkg_install nodejs
kpkg_install libwebp
kpkg_install xorg-lib/libXcomposite
kpkg_install xorg-lib/libXcursor
kpkg_install xorg-lib/libXdamage
kpkg_install xorg-lib/libICE
kpkg_install xorg-lib/libSM
kpkg_install libnotify
kpkg_install firefox

# pcmanfm-gtk3 #
kpkg_install libfm-extra
kpkg_install menu-cache
kpkg_install libfm-gtk3
kpkg_install pcmanfm-gtk3
