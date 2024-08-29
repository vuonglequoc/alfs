#!/bin/bash

# Firefox 125 - NSS 3.99
# https://wiki.mozilla.org/NSS:Release_Versions
KPKG_SRC_FILE=firefox-125.0.3.source.tar.xz
KPKG_SRC_FOLDER=firefox-125.0.3

k_configure() {
cat > mozconfig << "EOF"
# If you have a multicore machine, all cores will be used by default.

# If you have installed (or will install) wireless-tools, and you wish
# to use geolocation web services, comment out this line
ac_add_options --disable-necko-wifi

# Comment out the following line if you wish not to use Google's Location
# Service (GLS).  Note that if Geoclue is installed and configured to use
# GLS (as the BLFS instruction does), Firefox can access GLS via Geoclue
# anyway.  On the other hand if Geoclue is not installed (or not properly
# configured) and this line is commented out, the website requiring a
# location service will not function properly.
ac_add_options --with-google-location-service-api-keyfile=$PWD/google-key

# startup-notification is required since firefox-78

# Uncomment the following option if you have not installed PulseAudio and
# want to use alsa instead
#ac_add_options --enable-audio-backends=alsa

# Comment out following options if you have not installed
# recommended dependencies:
ac_add_options --with-system-icu
ac_add_options --with-system-libevent
ac_add_options --with-system-libvpx
ac_add_options --with-system-nspr
ac_add_options --with-system-nss
ac_add_options --with-system-webp

# The libdav1d library (av1 decoder) requires nasm. Uncomment this
# if nasm has not been installed. Do not uncomment this if you have
# ffmpeg installed.
#ac_add_options --disable-av1

# You cannot distribute the binary if you do this.
ac_add_options --enable-official-branding

# Stripping is now enabled by default.
# Uncomment these lines if you need to run a debugger:
#ac_add_options --disable-strip
#ac_add_options --disable-install-strip

# Disabling debug symbols makes the build much smaller and a little
# faster. Comment this if you need to run a debugger.
ac_add_options --disable-debug-symbols

# The BLFS editors recommend not changing anything below this line:
ac_add_options --prefix=/usr
ac_add_options --enable-application=browser
ac_add_options --disable-crashreporter
ac_add_options --disable-updater

# Enabling the tests will use a lot more space and significantly
# increase the build time, for no obvious benefit.
ac_add_options --disable-tests

# This enables SIMD optimization in the shipped encoding_rs crate.
# ac_add_options --enable-rust-simd
# The Rust code for SIMD optimization is much more outdated
# so it does not build with recent Rustc.
ac_add_options --disable-rust-simd

ac_add_options --enable-system-ffi
ac_add_options --enable-system-pixman

ac_add_options --with-system-jpeg
ac_add_options --with-system-png
ac_add_options --with-system-zlib

# Sandboxing works well on x86_64 but might cause issues on other
# platforms, e.g. i686.
[ $(uname -m) != x86_64 ] && ac_add_options --disable-sandbox

# Using sandboxed wasm libraries has been moved to all builds instead
# of only mozilla automation builds. It requires extra llvm packages
# and was reported to seriously slow the build. Disable it.
ac_add_options --without-wasm-sandboxed-libraries

# The following option unsets Telemetry Reporting. With the Addons Fiasco,
# Mozilla was found to be collecting user's data, including saved passwords and
# web form data, without users consent. Mozilla was also found shipping updates
# to systems without the user's knowledge or permission.
# As a result of this, use the following command to permanently disable
# telemetry reporting in Firefox.
unset MOZ_TELEMETRY_REPORTING

mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-build-dir
EOF

sed 's/input.try/&_parse/' \
    -i servo/components/style_traits/values.rs &&
sed '0,/"Keyframe"/{//d}' -i servo/ports/geckolib/cbindgen.toml

for i in {43..47}; do
   sed -i '/ZWJ/s/}/,CLASS_CHARACTER&/' intl/lwbrk/LineBreaker.cpp 
done

echo "AIzaSyDxKL42zsPjbke5O8_rPVpVrLrJ8aeE9rQ" > google-key
}

k_build() {
  export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=none &&
  export MOZBUILD_STATE_PATH=${PWD}/mozbuild          &&
  ./mach build
}

k_check() {
  :
}

k_install() {
  export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=none &&
  ./mach install
}

k_post_install() {
unset MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE
unset MOZBUILD_STATE_PATH

# Configuring Firefox
mkdir -pv /usr/share/applications
mkdir -pv /usr/share/pixmaps

MIMETYPE="text/xml;text/mml;text/html;"
MIMETYPE+="application/xhtml+xml;application/vnd.mozilla.xul+xml;"
MIMETYPE+="x-scheme-handler/http;x-scheme-handler/https"

cat > /usr/share/applications/firefox.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Exec=firefox %u
Terminal=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=$MIMETYPE
StartupNotify=true
EOF

unset MIMETYPE

ln -sfv /usr/lib/firefox/browser/chrome/icons/default/default128.png \
        /usr/share/pixmaps/firefox.png
}

k_pre_record() {
  mkdir -p $KPKG_TMP_DIR/usr/lib/
  mkdir -p $KPKG_TMP_DIR/usr/bin/
  mkdir -p $KPKG_TMP_DIR/usr/share/applications
  mkdir -p $KPKG_TMP_DIR/usr/share/pixmaps
  cp -r /usr/bin/firefox $KPKG_TMP_DIR/usr/bin/firefox
  cp -r /usr/lib/firefox/* $KPKG_TMP_DIR/usr/lib/firefox/
  cp /usr/share/applications/firefox.desktop $KPKG_TMP_DIR/usr/share/applications/firefox.desktop
  ln -sfv $KPKG_TMP_DIR/usr/lib/firefox/browser/chrome/icons/default/default128.png \
          $KPKG_TMP_DIR/usr/share/pixmaps/firefox.png
}
