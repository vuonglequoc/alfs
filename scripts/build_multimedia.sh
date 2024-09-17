#!/bin/bash

#   alsa-ucm-conf-1.2.12
#   elogind-255.5                   ???
# alsa-lib-1.2.12

#   libaom-3.9.1
#     FreeType-2.13.2
#     FriBidi-1.0.15
#     NASM-2.16.03
#       FreeType-2.13.2
#     Fontconfig-2.15.0
#         libxslt-1.1.42
#         pcre2-10.44
#         dbus-1.14.10            ???
#         docbook-xml-4.5
#         docbook-xsl-nons-1.79.2
#         packaging-23.2
#         docutils-0.20.1          
#       GLib-2.81.0
#       Graphite2-1.3.14
#     harfBuzz-9.0.0
#   libass-0.17.3
#   fdk-aac-2.0.3
#   FreeType-2.13.2
#   LAME-3.100
#     libogg-1.3.5
#   libvorbis-1.3.7
#     yasm-1.3.0 or NASM-2.16.03
#     Which-2.21
#   libvpx-1.14.1
#   Opus-1.5.2
#   x264
#     CMake
#   x265
#   NASM-2.16.03 or yasm-1.3.0
#   alsa-lib-1.2.12
#     alsa-lib-1.2.12
#     PulseAudio-17.0
#   SDL2
# FFmpeg-7.0.2

#   alsa-lib-1.2.12
#   FFmpeg-7.0.2
#     libsndfile-1.2.2
#   PulseAudio-17.0
# alsa-plugins-1.2.12

#   alsa-lib-1.2.12
# alsa-utils-1.2.12

#   alsa-lib-1.2.12
#   FLTK-1.3.9                      ???
# alsa-tools-1.2.11

#   alsa-tools-1.2.11
# alsa-firmware-1.2.4

#   alsa-lib-1.2.12
#   FFmpeg-7.0.2
#   liba52-0.8.0
#   libgcrypt-1.11.0
#   Lua-5.2.4
#   libssh2
#   libogg-1.3.5
#   libaom-3.9.1
#   libass-0.17.3
#   libvorbis-1.3.7
#   Opus-1.5.2
#   libvpx-1.14.1
#   x264
#   Fontconfig-2.15.0
#   FreeType-2.13.2
#   FriBidi-1.0.15
#   PulseAudio-17.0
# VLC-3.0.21

#   alsa-lib-1.2.12
#   FFmpeg-7.0.2
#   libass-0.17.3
#     FFmpeg-7.0.2
#     Glad-2.0.6
#       Vulkan-Headers
#     Vulkan-Loader           ???
#   libplacebo-7.349.0
#   Mesa-24.1.4               ???
#   PulseAudio-17.0
#   libva-2.22.0              ???
#   libvdpau-1.5              ???
#   Lua-5.2.4
#   SDL2
#   libcdio-2.1.0
#     libdvdread-6.1.3
#   libdvdnav-6.1.1
# mpv-0.38.0

if [ -z "$NONROOT_USER" ]
  then echo "Please check environment variable NONROOT_USER"
  exit
fi

source /alfs/kpkg/kpkg.sh

kpkg_install alsa-lib
# Update Linux Kernel for Sound
cd /sources/linux-6.10.7
cp /alfs/defaults/boot/config-6.10.7.base.uefi.iptables.ntfs.exfat.sound .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$(uname -r)-lfs-12.2
cp -v System.map /boot/System.map-$(uname -r)-lfs-12.2
cp -v .config /boot/config-$(uname -r)-lfs-12.2

kpkg_install libaom
kpkg_install fribidi
kpkg_install fontconfig
kpkg_install pcre2
kpkg_install python/packaging
kpkg_install python/docutils
kpkg_install glib_pre # glib without gobject-introspection
kpkg_install gobject-introspection
kpkg_install glib # glib with gobject-introspection
kpkg_install graphite2
kpkg_install harfbuzz
kpkg_install freetype # reinstall
kpkg_install libass
kpkg_install fdk-aac
kpkg_install lame
kpkg_install libogg
kpkg_install libvorbis
kpkg_install which
kpkg_install libvpx
kpkg_install opus
kpkg_install x264
kpkg_install x265
kpkg_install sdl2
kpkg_install ffmpeg
# Update Linux Kernel for Framebuffer /dev/fb0
cd /sources/linux-6.10.7
cp /alfs/defaults/boot/config-6.10.7.base.uefi.iptables.ntfs.exfat.sound.framebuffer .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$(uname -r)-lfs-12.2
cp -v System.map /boot/System.map-$(uname -r)-lfs-12.2
cp -v .config /boot/config-$(uname -r)-lfs-12.2

kpkg_install libsndfile
kpkg_install pulseaudio
kpkg_install alsa-plugins

kpkg_install alsa-utils

kpkg_install alsa-tools

kpkg_install alsa-firmware

kpkg_install liba52
kpkg_install lua
kpkg_install vlc

kpkg_install python/glad2
kpkg_install vulkan-headers
kpkg_install libplacebo
kpkg_install libcdio
kpkg_install libcdio-paranoia
kpkg_install libdvdread
kpkg_install libdvdnav
kpkg_install mpv
