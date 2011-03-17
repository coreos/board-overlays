# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Atmel mxt touchscreen config files"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

src_install() {
	insinto /etc/udev/rules.d
	doins ${FILESDIR}/99-atmel-touch.rules
	insinto /etc
	doins ${FILESDIR}/touch-devices
}
