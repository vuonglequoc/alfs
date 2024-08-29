#!/bin/bash

#   alsa-ucm-conf-1.2.12
#   elogind-255.5                   ???
# alsa-lib-1.2.12
#   alsa-lib-1.2.12
#     libaom-3.9.1
#       FreeType-2.13.2
#       FriBidi-1.0.15
#       NASM-2.16.03
#         FreeType-2.13.2
#       Fontconfig-2.15.0
#           libxslt-1.1.42
#           pcre2-10.44
#           dbus-1.14.10            ???
#           docbook-xml-4.5
#           docbook-xsl-nons-1.79.2
#           packaging-23.2
#           docutils-0.20.1          
#         GLib-2.81.0
#         Graphite2-1.3.14
#       harfBuzz-9.0.0
#     libass-0.17.3
#     fdk-aac-2.0.3
#     FreeType-2.13.2
#     LAME-3.100
#       libogg-1.3.5
#     libvorbis-1.3.7
#       yasm-1.3.0 or NASM-2.16.03
#       Which-2.21
#     libvpx-1.14.1
#     Opus-1.5.2
#     x264-20240216
#       CMake-3.30.1
#     x265-20240216
#     NASM-2.16.03 or yasm-1.3.0
#     alsa-lib-1.2.12
#       alsa-lib-1.2.12
#       PulseAudio-17.0
#     SDL2-2.30.5
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
#   libssh2-1.11.0
#   libogg-1.3.5
#   libaom-3.9.1
#   libass-0.17.3
#   libvorbis-1.3.7
#   Opus-1.5.2
#   libvpx-1.14.1
#   x264-20240216
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
#       Vulkan-Headers-1.3.290
#     Vulkan-Loader-1.3.290           ???
#   libplacebo-7.349.0
#   Mesa-24.1.4
#   PulseAudio-17.0
#   libva-2.22.0
#   libvdpau-1.5
#   Lua-5.2.4
#   SDL2-2.30.5
#   libcdio-2.1.0
#     libdvdread-6.1.3
#   libdvdnav-6.1.1
# mpv-0.38.0

if [ -z "$NONROOT_USER" ]
  then echo "Please check environment variable NONROOT_USER"
  exit
fi

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages alsa-lib
# Update Linux Kernel for Sound
cd /sources/linux-6.7.4
cp /alfs/defaults/boot/config-6.7.4.base.uefi.iptables.ntfs.sound .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$(uname -r)-lfs-12.1
cp -v System.map /boot/System.map-$(uname -r)-lfs-12.1
cp -v .config /boot/config-$(uname -r)-lfs-12.1

kpkg_install /alfs packages libaom
kpkg_install /alfs packages fribidi
kpkg_install /alfs packages fontconfig
kpkg_install /alfs packages pcre2
kpkg_install /alfs packages python/packaging
kpkg_install /alfs packages python/docutils
kpkg_install /alfs packages glib
kpkg_install /alfs packages graphite2
kpkg_install /alfs packages harfbuzz
kpkg_install /alfs packages freetype # reinstall
kpkg_install /alfs packages libass
kpkg_install /alfs packages fdk-aac
kpkg_install /alfs packages lame
kpkg_install /alfs packages libogg
kpkg_install /alfs packages libvorbis
kpkg_install /alfs packages which
kpkg_install /alfs packages libvpx
kpkg_install /alfs packages opus
kpkg_install /alfs packages x264
kpkg_install /alfs packages x265
kpkg_install /alfs packages sdl2
kpkg_install /alfs packages ffmpeg
# Update Linux Kernel for Framebuffer /dev/fb0
cd /sources/linux-6.7.4
cp /alfs/defaults/boot/config-6.7.4.base.uefi.iptables.ntfs.sound.framebuffer .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$(uname -r)-lfs-12.1
cp -v System.map /boot/System.map-$(uname -r)-lfs-12.1
cp -v .config /boot/config-$(uname -r)-lfs-12.1

kpkg_install /alfs packages libsndfile
kpkg_install /alfs packages pulseaudio
kpkg_install /alfs packages alsa-plugins
kpkg_install /alfs packages alsa-utils
kpkg_install /alfs packages alsa-tools
kpkg_install /alfs packages alsa-firmware
kpkg_install /alfs packages liba52
kpkg_install /alfs packages lua
kpkg_install /alfs packages vlc
kpkg_install /alfs packages python/glad2
kpkg_install /alfs packages vulkan-headers
kpkg_install /alfs packages libplacebo
kpkg_install /alfs packages libcdio
kpkg_install /alfs packages libdvdread
kpkg_install /alfs packages libdvdnav
kpkg_install /alfs packages mpv
