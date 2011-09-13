# Copyright (c) 2009-2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 seaboard overlay specific xorg configuration file."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="touchui"

RDEPEND="chromeos-base/xorg-conf"

src_install() {
	insinto /etc/X11/xorg.conf.d
	if use touchui; then
		newins "${FILESDIR}/touchscreen-mxt.conf" 60-touchscreen-mxt.conf
	fi
}
