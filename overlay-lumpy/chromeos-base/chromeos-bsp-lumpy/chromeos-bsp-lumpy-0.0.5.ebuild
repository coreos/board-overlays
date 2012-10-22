# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
PROVIDE="virtual/chromeos-bsp"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="${RDEPEND}
	sys-apps/iotools
"
DEPEND=""

RDEPEND="${RDEPEND}
	chromeos-base/light-sensor
"

# Y3300 support.
RDEPEND="${RDEPEND}
	virtual/modemmanager
"

# Unclutter. Putting here temporarily to test on one platform before
# deploying on all platforms
RDEPEND="${RDEPEND}
	x11-misc/unclutter
"

src_install() {
	doappid "{A854E62E-9CB3-4DBE-8BBE-88C48FD65787}" || die "appid failed ($?)"
	dosbin "${FILESDIR}/activate_date" || die "installation failed ($?)"
	dosbin "${FILESDIR}/battery_cut_off.sh" || die "installation failed ($?)"
	dosbin "${FILESDIR}/board_factory_wipe.sh" || die "installation failed ($?)"
	dosbin "${FILESDIR}/board_factory_reset.sh" || die "installation failed ($?)"

	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/usb-autosuspend.conf" || die "installation failed ($?)"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager"
	doins "${FILESDIR}/wakeup_input_device_names" || die "installation failed ($?)"
}
