#!/bin/bash

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages fcron

/alfs/scripts/build_initramfs.sh

kpkg_install /alfs packages cpio
kpkg_install /alfs packages pciutils

# Firmware
/alfs/scripts/build_firmware.sh

# The Bash Shell Startup Files
/alfs/scripts/conf_bash_shell.sh

# The /etc/vimrc and ~/.vimrc Files
/alfs/scripts/conf_vim.sh

# Customizing your Logon with /etc/issue
/alfs/scripts/customize_logon_message.sh

# Random Number Generation
/alfs/scripts/fix_random_generator.sh

# Security
/alfs/scripts/build_security.sh

# File Systems and Disk Management
/alfs/scripts/build_file_system_and_disk_mng.sh
