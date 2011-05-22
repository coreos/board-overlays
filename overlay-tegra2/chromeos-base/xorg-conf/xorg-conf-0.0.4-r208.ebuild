# Copyright (c) 2009-2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 overlay specific xorg configuration file."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="-touchui multitouch"

RDEPEND=""

src_install() {
	insinto /etc/X11
	newins "${FILESDIR}/xorg.conf" xorg.conf

	insinto /etc/X11/xorg.conf.d
	newins "${FILESDIR}/tegra.conf" tegra.conf
	if use multitouch; then
		newins "${FILESDIR}/touchpad-multitouch.conf" 50-touchpad-multitouch.conf
	fi
	if use touchui; then
		newins "${FILESDIR}/touchscreen-mxt.conf" 60-touchscreen-mxt.conf
	fi
}
