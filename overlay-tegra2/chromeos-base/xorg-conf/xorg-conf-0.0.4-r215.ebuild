# Copyright (c) 2009-2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 overlay specific xorg configuration file."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="multitouch cmt"

RDEPEND=""

src_install() {
	insinto /etc/X11/xorg.conf.d
	newins "${FILESDIR}/tegra.conf" tegra.conf
	if use cmt; then
		newins "${FILESDIR}/touchpad-cmt.conf" 50-touchpad-cmt.conf
	elif use multitouch; then
		newins "${FILESDIR}/touchpad-multitouch.conf" 50-touchpad-multitouch.conf
	fi
	newins "${FILESDIR}/20-mouse.conf" 20-mouse.conf
}
