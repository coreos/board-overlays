# Copyright (c) 2009-2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 overlay specific xorg configuration file."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="aebl cmt kaen multitouch"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	insinto /etc/X11/xorg.conf.d
	doins "${FILESDIR}/tegra.conf"
	if use cmt; then
		doins "${FILESDIR}/50-touchpad-cmt.conf"
		if use aebl; then
			doins "${FILESDIR}/50-touchpad-cmt-aebl.conf"
		elif use kaen; then
			doins "${FILESDIR}/50-touchpad-cmt-kaen.conf"
		fi
	elif use multitouch; then
		doins "${FILESDIR}/50-touchpad-multitouch.conf"
	fi
	doins "${FILESDIR}/20-mouse.conf"
}
