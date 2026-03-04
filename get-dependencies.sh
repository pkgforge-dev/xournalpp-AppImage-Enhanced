#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm xournalpp patchelf

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# gtk3-mini breaks xornalpp because it lacks symbol gdk_broadway_display_get_type
# lets provide a dummy instead
echo 'unsigned long gdk_broadway_display_get_type(void) { return 0UL; }' > ./kek.c
gcc -shared -fPIC -o kek.so kek.c
cp -v ./kek.so /usr/lib
patchelf --add-needed kek.so /usr/bin/xournalpp /usr/bin/xournalpp-wrapper

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
