# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2
CROS_WORKON_COMMIT="ef29bf377b463311015da261580f85c076aed218"
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

# TODO(hungte) make this into option CROS_FIRMWARE_UNSTABLE
pkg_postinst() {
	# Don't execute the updater on ARM platform because the firmware is
	# compiled from source, changed frequently, and not tested enough.
	# It may damage devices if it has bugs.
	touch "${ROOT}"/root/.leave_firmware_alone ||
		die "Cannot disable firmware updating"
}

# ---------------------------------------------------------------------------
# CUSTOMIZATION SECTION

# Remove the tegra2_ prefix from board name and capitalize it.
# TODO(hungte) support boards with more variants postfix like -xx or _yy.
BOARD="${BOARD:-${SYSROOT##/build/}}"
BOARD_NAME="${BOARD##*_}"
CROS_FIRMWARE_PLATFORM="${CROS_FIRMWARE_PLATFORM:-${BOARD_NAME^*}}"

# System firmware image.
CROS_FIRMWARE_MAIN_IMAGE="${ROOT}/u-boot/image.bin"
CROS_FIRMWARE_EXTRA_LIST="${FILESDIR}/extra"
