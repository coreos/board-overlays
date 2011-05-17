# Copyright (c) 2009-2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 overlay specific xorg configuration file."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="opengles -touchui multitouch"

RDEPEND=""

src_install() {
	insinto /etc/X11
	if use touchui; then
		newins "${FILESDIR}/xorg.conf.touch" xorg.conf
	elif use opengles; then
		newins "${FILESDIR}/xorg.conf.opengles" xorg.conf
	else
		newins "${FILESDIR}/xorg.conf.fbdev" xorg.conf
	fi

	insinto /etc/X11/xorg.conf.d
	if use multitouch; then
		newins "${FILESDIR}/touchpad.conf-multitouch" touchpad.conf
	fi
}
