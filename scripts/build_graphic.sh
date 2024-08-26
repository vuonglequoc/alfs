#!/bin/bash

#   meson *
#     libxml2
#   wayland
#   wayland-protocols *
#     meson
#     wayland
#     wayland-protocols
#     EGL and GLESv2 (optional, for the GLES2 renderer)
#     Vulkan loader, headers and glslang (optional, for the Vulkan renderer)
#       libpciaccess
#     libdrm
#     GBM (optional, for the GBM allocator)
#       mtdev
#         libevdev
#                 libxslt-1.1.39
#                 pcre2-10.42
#                 dbus-1.14.10
#                 docbook-xml-4.5
#                 docbook-xsl-nons-1.79.2
#                 packaging-23.2
#                 docutils-0.20.1
#           GLib-2.80.4
#         libgudev
#       libwacom
#     libinput (optional, for the libinput backend)
#     pixman
#       xkeyboard-config-2.42
#             util-macros-1.20.1
#           xorgproto-2024.1
#         libXau-1.0.11
#         xcb-proto-1.17.0
#       libxcb-1.17.0
#       Wayland-1.23.0
#       wayland-protocols-1.36
#         libxcvt-0.1.2
#         font-util-1.4.1
#       Xvfb from Xwayland-24.1.2 ???
#     libxkbcommon
#     udev (optional, for the session)
#     libseat (optional, for the session)
#     hwdata (optional, for the DRM backend)
#       hwdata-0.385
#     libdisplay-info (optional, for the DRM backend)
#     libliftoff (optional, for the DRM backend)
#   wlroots
#   pcre2
#     CMake-3.30.2
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
#       CMake-3.30.2
#       libjpeg-turbo-3.0.1
#     libtiff
#     shared-mime-info-2.4
#   gdk-pixbuf (optional: additional image formats for system tray)
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

#   tllist-1.1.0
#   fcft-3.1.8
# foot-1.18.0

# wofi-1.2.4

# swayidle-1.8.0
# swaylock-1.7.2

#     Gtkmm
#     JSON-GLib-1.8.0
#     libsigc++
#     PulseAudio
#     libcanberra-0.30
# pavucontrol-5.0

#     basu-0.2.0
# mako-1.9.0

#       rust
#       gdk-pixbuf
#       pango
#       vala
#       libxfce4util ?
#     librsvg
#   cairo
#     XKeyboardConfig
#     libxcb
#     Wayland
#     Wayland-Protocols
#   libxkbcommon
#     dbus
#     libXtst
#   at-spi2-core
#         spirv-headers
#       spirv-tools
#     Glslang
#         spirv-tools
#       spirv-llvm-translator
#     libclc
#     Libdrm
#     Mako
#     ply
#     Cbindgen
#     rust-bindgen
#     libXxf86vm
#     libxshmfence
#   Mesa
#     Mesa
#   libepoxy
#   docbook-xml
#   docbook-xsl-nons
#   libXrandr
#     libXfixes
#   libXi
# GTK+
#     Cairo-1.18.0
#           mm-common-1.0.6
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
# waybar

# Themes
# Icons
# Fonts
# Config

source /alfs/kpkg/kpkg.sh

export XORG_PREFIX=/usr
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static"
export XORG_CONFIG2="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var"
export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig"
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib

kpkg_install /alfs packages wayland/wayland
kpkg_install /alfs packages wayland/wayland-protocols
kpkg_install /alfs packages xorg-lib/libpciaccess
kpkg_install /alfs packages libdrm
kpkg_install /alfs packages mtdev
kpkg_install /alfs packages xorg-input-drivers/libevdev
kpkg_install /alfs packages libgudev
kpkg_install /alfs packages libwacom
kpkg_install /alfs packages xorg-input-drivers/libinput
kpkg_install /alfs packages pixman
kpkg_install /alfs packages xorg-data/xkeyboard-config
kpkg_install /alfs packages xorg-util/util-macros
kpkg_install /alfs packages xorg/xorgproto
kpkg_install /alfs packages xorg-lib/libXau
kpkg_install /alfs packages xorg/xcb-proto
kpkg_install /alfs packages xorg/libxcb
kpkg_install /alfs packages xorg-lib/libxcvt
kpkg_install /alfs packages xorg-font/font-util
# kpkg_install /alfs packages Xvfb
kpkg_install /alfs packages libxkbcommon
kpkg_install /alfs packages seatd
kpkg_install /alfs packages hwdata
kpkg_install /alfs packages libdisplay-info
kpkg_install /alfs packages wayland/wlroots
kpkg_install /alfs packages json-c
kpkg_install /alfs packages xorg-lib/xtrans
kpkg_install /alfs packages xorg-lib/libX11
kpkg_install /alfs packages xorg-lib/libXext
kpkg_install /alfs packages xorg-lib/libXrender
kpkg_install /alfs packages cairo
kpkg_install /alfs packages dbus
kpkg_install /alfs packages vala
kpkg_install /alfs packages librsvg
# rebuild cairo
kpkg_install /alfs packages cairo
# rebuild harfbuzz
kpkg_install /alfs packages harfbuzz
kpkg_install /alfs packages pango
kpkg_install /alfs packages libtiff
kpkg_install /alfs packages shared-mime-info
kpkg_install /alfs packages gdk-pixbuf

# https://git.sr.ht/~sircmpwn/scdoc/archive/1.11.3.tar.gz
# make PREFIX=/usr
# sudo make PREFIX=/usr install
# kpkg_install /alfs packages scdoc

kpkg_install /alfs packages wayland/swaybg
kpkg_install /alfs packages wayland/sway

kpkg_install /alfs packages wayland/tllist
kpkg_install /alfs packages wayland/fcft
kpkg_install /alfs packages wayland/foot

kpkg_install /alfs packages wayland/wofi

# 4.4 System idle: swayidle + swaylock
kpkg_install /alfs packages wayland/swayidle
kpkg_install /alfs packages wayland/swaylock

# 4.5 Sound: pipewire + alsamixer
kpkg_install /alfs packages json-glib
kpkg_install /alfs packages libcanberra
kpkg_install /alfs packages pavucontrol

# 4.6 Screenshots: wayshot (grimshot)

# 4.7 Clipboard manager: copyq
# qt5
# https://github.com/hluk/CopyQ/releases/download/v9.0.0/CopyQ-9.0.0.tar.gz
# cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ..

# 4.8 Notifications: mako
kpkg_install /alfs packages wayland/basu
kpkg_install /alfs packages wayland/mako

# waybar
kpkg_install /alfs packages xorg-lib/libXtst
kpkg_install /alfs packages at-spi2-core
kpkg_install /alfs packages python/Mako
kpkg_install /alfs packages SPIRV-Headers
kpkg_install /alfs packages SPIRV-Tools
kpkg_install /alfs packages glslang
kpkg_install /alfs packages SPIRV-LLVM-Translator
kpkg_install /alfs packages libclc
kpkg_install /alfs packages python/ply
kpkg_install /alfs packages cbindgen
kpkg_install /alfs packages rust-bindgen
kpkg_install /alfs packages xorg-lib/libXxf86vm
kpkg_install /alfs packages xorg-lib/libxshmfence
kpkg_install /alfs packages mesa
kpkg_install /alfs packages libepoxy
kpkg_install /alfs packages xorg-lib/libXrandr
kpkg_install /alfs packages xorg-lib/libXfixes
kpkg_install /alfs packages xorg-lib/libXi
kpkg_install /alfs packages gtk+
kpkg_install /alfs packages mm-common
kpkg_install /alfs packages libsigc++
kpkg_install /alfs packages libcairomm-1.0
kpkg_install /alfs packages glibmm
kpkg_install /alfs packages atkmm
kpkg_install /alfs packages pangomm
kpkg_install /alfs packages gtkmm

# gtk-layer-shell
# libgtk-3-dev
# gobject-introspection
# libgirepository1.0-dev

# Pulseaudio module
# libpulse

# Network module
kpkg_install /alfs packages libnl

# Tray module
# libappindicator-gtk3
kpkg_install /alfs packages gnome-common
kpkg_install /alfs packages python-dep/editables
kpkg_install /alfs packages python-dep/pathspec
kpkg_install /alfs packages python-dep/setuptools_scm
kpkg_install /alfs packages python-dep/pluggy
kpkg_install /alfs packages python-dep/trove-classifiers
kpkg_install /alfs packages python-dep/hatchling
kpkg_install /alfs packages python/Pygments
kpkg_install /alfs packages itstool
kpkg_install /alfs packages gtk-doc-tools
kpkg_install /alfs packages libdbusmenu-gtk3

# MPD module
kpkg_install /alfs packages libmpdclient

# sndio module
kpkg_install /alfs packages libsndio

# KeyboardState module
# libevdev installed

# UPower battery module
kpkg_install /alfs packages upower

# libinotify
# epoll-shim
# libpipewire-0.3
# playerctl
# jack
# wireplumber-0.5
# clang-tidy

kpkg_install /alfs packages fftw
kpkg_install /alfs packages iniparser
kpkg_install /alfs packages cava
kpkg_install /alfs packages fmt
kpkg_install /alfs packages Catch2
# https://gitlab.archlinux.org/archlinux/packaging/packages/spdlog/-/raw/main/spdlog_fmt_external.patch
# patch -p1 <../spdlog_fmt_external.patch
kpkg_install /alfs packages spdlog
kpkg_install /alfs packages wayland/Waybar

# Themes
# /usr/share/themes
kpkg_install /alfs packages themes/Nordic-darker

# Icons
# /usr/share/icons/
kpkg_install /alfs packages icons/adwaita-icon-theme
kpkg_install /alfs packages icons/hicolor-icon-theme
wget -qO- https://git.io/papirus-icon-theme-install | sh
# wget -qO- https://git.io/papirus-icon-theme-uninstall | sh

# Fonts
# /usr/share/fonts
sudo mkdir -p /usr/share/fonts/opentype
sudo mkdir -p /usr/share/fonts/truetype
kpkg_install /alfs packages fonts/FontAwesome
kpkg_install /alfs packages fonts/Ubuntu
kpkg_install /alfs packages fonts/FiraCode
kpkg_install /alfs packages fonts/NotoSansJP
