# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2
CROS_WORKON_COMMIT="649fea56e87e979a248f4e0f98e4774a1ae3d46c"
CROS_WORKON_TREE="64205a6bd304eb66867be13467faf30d961c1378"

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
CROS_FIRMWARE_MAIN_IMAGE="${ROOT}/firmware/image.bin"
CROS_FIRMWARE_EXTRA_LIST="${FILESDIR}/extra"
