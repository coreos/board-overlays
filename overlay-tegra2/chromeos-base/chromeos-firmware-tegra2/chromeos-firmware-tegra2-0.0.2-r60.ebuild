# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2
CROS_WORKON_COMMIT=8a8d726fed8eceeb500268a3f347e007896f3e3a
CROS_WORKON_TREE="ed880f8249353b30651b1ebb5badedb5e1cb51b3"

EAPI=2
CROS_WORKON_PROJECT="chromiumos/platform/firmware"

inherit cros-workon cros-firmware

CROS_WORKON_LOCALNAME="firmware"

DESCRIPTION="Chrome OS Firmware"
HOMEPAGE="http://www.chromium.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND="${DEPEND} sys-boot/chromeos-bootimage"
SRC_URI=""

# ---------------------------------------------------------------------------
# CUSTOMIZATION SECTION

# Remove the tegra2_ prefix from board name and capitalize it.
# TODO(hungte) support boards with more variants postfix like -xx or _yy.
BOARD="${BOARD:-${SYSROOT##/build/}}"
BOARD_NAME="${BOARD##*_}"
CROS_FIRMWARE_PLATFORM="${CROS_FIRMWARE_PLATFORM:-${BOARD_NAME^*}}"

# Use v3 updater
CROS_FIRMWARE_SCRIPT="updater3.sh"
CROS_FIRMWARE_UNSTABLE="TRUE"

# System firmware image.
CROS_FIRMWARE_MAIN_IMAGE="${ROOT}/firmware/image-${BOARD_NAME}.bin"

# TODO(sjg@chromium.org): Remove this when this change goes in:
# https://gerrit.chromium.org/gerrit/25151
if [ ! -r "${CROS_FIRMWARE_MAIN_IMAGE}" ]; then
	CROS_FIRMWARE_MAIN_IMAGE="${ROOT}/firmware/image.bin"
fi
CROS_FIRMWARE_EXTRA_LIST="${FILESDIR}/extra"
