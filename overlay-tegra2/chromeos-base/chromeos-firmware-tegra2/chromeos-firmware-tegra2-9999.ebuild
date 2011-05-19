# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2
CROS_WORKON_PROJECT="chromiumos/platform/firmware"

inherit cros-workon cros-firmware

DESCRIPTION="Chrome OS Firmware"
HOMEPAGE="http://www.chromium.org/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND="sys-boot/chromeos-bios"
RDEPEND="${DEPEND}"

CROS_WORKON_LOCALNAME="firmware"

pkg_postinst() {
	# Don't execute the updater on ARM platform because the firmware is
	# compiled from source, changed frequently, and not tested enough.
	# It may damage devices if it has bugs.
	touch "${ROOT}"/root/.leave_firmware_alone ||
		die "Cannot disable firmware updating"
}

# ---------------------------------------------------------------------------
# CUSTOMIZATION SECTION

# System firmware image.
CROS_FIRMWARE_MAIN_IMAGE="${ROOT}/u-boot/image.bin"
CROS_FIRMWARE_EXTRA_LIST="${FILESDIR}/extra"
