#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm xournalpp

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
                                       # this app depends on broadway symbols
                                       # so gtk3-mini is not possible
get-debloated-pkgs --add-common --prefer-nano ! gtk3-mini

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
