#!/bin/bash

# wayland
#   wayland
# wayland-protocols *

#       spirv-headers
#     spirv-tools
#   Glslang
#       spirv-tools
#     spirv-llvm-translator
#   libclc
#     libpciaccess
#   Libdrm
#   Mako
#   ply
#   Cbindgen
#   rust-bindgen
#   libXxf86vm
#   libxshmfence
# Mesa

#   meson
#   wayland
#   wayland-protocols
#   [Mesa] EGL and GLESv2 (optional, for the GLES2 renderer)
#   Vulkan loader, headers and glslang (optional, for the Vulkan renderer)
#   libdrm
#   [Mesa] GBM (optional, for the GBM allocator)
#     mtdev
#       libevdev
#           libxslt-1.1.39
#           pcre2-10.42
#           dbus-1.14.10
#           docbook-xml-4.5
#           docbook-xsl-nons-1.79.2
#           packaging-23.2
#           docutils-0.20.1
#         GLib-2.80.4
#       libgudev
#     libwacom
#   libinput (optional, for the libinput backend)
#   pixman
#     xkeyboard-config-2.42
#           util-macros-1.20.1
#         xorgproto-2024.1
#       libXau-1.0.11
#       xcb-proto-1.17.0
#     libxcb-1.17.0
#     Wayland-1.23.0
#     wayland-protocols-1.36
#       libxcvt-0.1.2
#       font-util-1.4.1
#     Xvfb from Xwayland-24.1.2 ???
#   libxkbcommon
#   udev (optional, for the session)
#   libseat (optional, for the session)
#   hwdata (optional, for the DRM backend)
#     hwdata-0.385
#   libdisplay-info (optional, for the DRM backend)
#   libliftoff (optional, for the DRM backend)
# wlroots

#   meson *
#     libxml2
#   wayland
#   wayland-protocols *
#   wlroots
#   pcre2
#     CMake
#   json-c
#     libpng-1.6.43
#     Pixman-0.43.4
#       harfBuzz-9.0.0
#       FreeType-2.13.2
#     Fontconfig-2.15.0
#     GLib-2.80.4
#     libdrm-2.4.122
#       xtrans
#     libX11
#     libXext
#     libXrender
#     librsvg (build later)
#   cairo
#     Fontconfig-2.15.0
#     FriBidi-1.0.15
#     GLib-2.80.4
#     Cairo-1.18.0
#   pango
#     Meson
#     GLib
#     libpng
#     libjpeg
#       CMake
#       libjpeg-turbo-3.0.1
#     libtiff
#     shared-mime-info-2.4
#   gdk-pixbuf (optional: additional image formats for system tray)
#       cairo
#       rust
#       pango
#         dbus
#       vala
#       gdk-pixbuf
#       libxfce4util ?
#     librsvg
#   cairo (rebuild) -> harfbuzz (rebuild)
#   scdoc (optional: man pages) *
#     meson *
#     wayland
#     wayland-protocols *
#     cairo
#     gdk-pixbuf (optional: image formats other than PNG)
#     scdoc (optional: man pages) *
#     git (optional: version information) *
#   swaybg (optional: wallpaper)
#   git (optional: version info) *
#   libevdev
#   libinput
#   libudev
# sway-1.9

#   cairo
#     XKeyboardConfig
#     libxcb
#     Wayland
#     Wayland-Protocols
#   libxkbcommon
#     dbus
#       libX11
#       libXext
#         libXfixes
#       libXi
#     libXtst
#   at-spi2-core
#     Mesa
#   libepoxy
#   docbook-xml
#   docbook-xsl-nons
#   libXrandr
#   libXi
# GTK+

#     Cairo-1.18.0
#       mm-common-1.0.6
#     libsigc++-2.12.1
#   libcairomm-1.0 (cairomm-1.14.5)
#   GTK+-3.24.43
#     at-spi2-core-2.52.0
#     GLibmm-2.66.7
#   Atkmm-2.28.4
#     libcairomm-1.14.5
#     GLibmm-2.66.7
#     Pango-1.54.0
#   Pangomm-2.46.4
# Gtkmm-3.24.9

#   Gtkmm-3.24.9
#   libnl
#     GTK+3
#     gnome-common
#         editables
#         packaging
#         pathspec
#           setuptools_scm
#         pluggy
#         trove-classifiers
#       hatchling
#     Pygments
#     itstool
#     gtk-doc-tools
#   libdbusmenu-gtk3
#   libmpdclient
#   libsndio
#   upower
#     fftw
#     iniparser
#   cava
#     fmt
#     Catch2
#   spdlog
#   gtk-layer-shell
#   jsoncpp
# waybar

#   tllist-1.1.0
#   fcft-3.1.8
# foot-1.18.0

#   GTK+3
# wofi-1.2.4

# swayidle-1.8.0
# swaylock-1.7.2

#   Gtkmm
#   JSON-GLib-1.8.0
#   libsigc++
#   PulseAudio
#   libcanberra-0.30
# pavucontrol-5.0

#   basu-0.2.0
# mako-1.9.0

# Themes
# Icons
# Fonts
# Config

if [ -z "$NONROOT_USER" ]
  then echo "Please check environment variable NONROOT_USER"
  exit
fi

source /alfs/kpkg/kpkg.sh

export XORG_PREFIX=/usr
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static"
export XORG_CONFIG2="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var"
export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig"
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib

# wayland #
kpkg_install wayland/wayland
kpkg_install wayland/wayland-protocols

# mesa #
kpkg_install SPIRV-Headers
kpkg_install SPIRV-Tools
kpkg_install glslang

kpkg_install SPIRV-LLVM-Translator
kpkg_install libclc

kpkg_install xorg-lib/libpciaccess
kpkg_install libdrm

kpkg_install python/Mako

kpkg_install python/ply

kpkg_install cbindgen

kpkg_install rust-bindgen

kpkg_install xorg-lib/libXxf86vm

kpkg_install xorg-lib/libxshmfence

kpkg_install mesa

# sway #
## wlroots ##
kpkg_install mtdev
kpkg_install xorg-input-drivers/libevdev
kpkg_install libgudev
kpkg_install libwacom
kpkg_install xorg-input-drivers/libinput

kpkg_install pixman

kpkg_install xorg-data/xkeyboard-config
kpkg_install xorg-util/util-macros
kpkg_install xorg/xorgproto
kpkg_install xorg-lib/libXau
kpkg_install xorg/xcb-proto
kpkg_install xorg/libxcb
kpkg_install xorg-lib/libxcvt
kpkg_install xorg-font/font-util
kpkg_install libxkbcommon

kpkg_install seatd
kpkg_install hwdata
kpkg_install libdisplay-info
kpkg_install libliftoff
kpkg_install wayland/wlroots

## json-c ##
kpkg_install json-c

## cairo ##
kpkg_install xorg-lib/xtrans
kpkg_install xorg-lib/libX11
kpkg_install xorg-lib/libXext
kpkg_install xorg-lib/libXrender
kpkg_install cairo

## pango ##
kpkg_install pango

kpkg_install libtiff
kpkg_install shared-mime-info
kpkg_install gdk-pixbuf
# depend on cairo, pango, harfbuzz, vala, gdk-pixbuf
kpkg_install dbus
kpkg_install vala
kpkg_install librsvg
# rebuild cairo
kpkg_install cairo
# rebuild harfbuzz
kpkg_install harfbuzz

# https://git.sr.ht/~sircmpwn/scdoc/archive/1.11.3.tar.gz
# make PREFIX=/usr
# sudo make PREFIX=/usr install
# kpkg_install scdoc

## swaybg ##
kpkg_install wayland/swaybg

kpkg_install wayland/sway
# sway #

# 4.0 Graphic toolkit GTK+3
kpkg_install xorg-lib/libXfixes
kpkg_install xorg-lib/libXi
kpkg_install xorg-lib/libXtst
kpkg_install at-spi2-core

kpkg_install libepoxy

kpkg_install xorg-lib/libXrandr

kpkg_install gtk+

# 4.1 Status bar: waybar
## gtkmm ##
kpkg_install mm-common
kpkg_install libsigc++
kpkg_install libcairomm-1.0

kpkg_install glibmm
kpkg_install atkmm

kpkg_install pangomm

kpkg_install gtkmm

# libgtk-3-dev
# gobject-introspection
# libgirepository1.0-dev

# Pulseaudio module
# libpulse

# Network module
## libnl ##
kpkg_install libnl

# Tray module
# libappindicator-gtk3
## libdbusmenu-gtk3 ##
kpkg_install gnome-common
kpkg_install python-dep/editables
kpkg_install python-dep/pathspec
kpkg_install python-dep/setuptools_scm
kpkg_install python-dep/pluggy
kpkg_install python-dep/trove-classifiers
kpkg_install python-dep/hatchling
kpkg_install python/Pygments
kpkg_install itstool
kpkg_install gtk-doc-tools
kpkg_install libdbusmenu-gtk3

# MPD module
## libmpdclient ##
kpkg_install libmpdclient

# sndio module
## libsndio ##
kpkg_install libsndio

# KeyboardState module
# libevdev installed

# UPower battery module
## upower ##
kpkg_install upower

# libinotify
# epoll-shim
# libpipewire-0.3
# playerctl
# jack
# wireplumber-0.5
# clang-tidy

## cava ##
kpkg_install fftw
kpkg_install iniparser
kpkg_install cava

## spdlog ##
kpkg_install fmt
kpkg_install Catch2
kpkg_install spdlog

## gtk-layer-shell ##
kpkg_install wayland/gtk-layer-shell

## jsoncpp ##
kpkg_install jsoncpp

kpkg_install wayland/Waybar

# 4.2 Terminal: foot
kpkg_install wayland/tllist
kpkg_install wayland/fcft
kpkg_install wayland/foot

# 4.3 Application launcher: wofi
kpkg_install wayland/wofi

# 4.4 System idle: swayidle + swaylock
kpkg_install wayland/swayidle
kpkg_install wayland/swaylock

# 4.5 Sound: pipewire + alsamixer
kpkg_install json-glib
kpkg_install libcanberra
kpkg_install pavucontrol

# 4.6 Screenshots: wayshot (grimshot)

# 4.7 Clipboard manager: copyq
# qt5
# https://github.com/hluk/CopyQ/releases/download/v9.0.0/CopyQ-9.0.0.tar.gz
# cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ..

# 4.8 Notifications: mako
kpkg_install wayland/basu
kpkg_install wayland/mako

# Themes
# /usr/share/themes
kpkg_install themes/Nordic-darker

# Icons
# /usr/share/icons/
#   GTK+-3.24.43
#   librsvg-2.58.3
kpkg_install icons/adwaita-icon-theme
kpkg_install icons/hicolor-icon-theme
wget -qO- https://git.io/papirus-icon-theme-install | sh
# wget -qO- https://git.io/papirus-icon-theme-uninstall | sh

# Fonts
# /usr/share/fonts
sudo mkdir -p /usr/share/fonts/opentype
sudo mkdir -p /usr/share/fonts/truetype
kpkg_install fonts/FontAwesome
kpkg_install fonts/Ubuntu
kpkg_install fonts/FiraCode
kpkg_install fonts/NotoSansJP
