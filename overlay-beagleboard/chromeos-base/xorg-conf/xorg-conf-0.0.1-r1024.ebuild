# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

# NOTE: This ebuild should be overrriden in an overlay to provide a
# board-specific xorg.conf as necessary.

EAPI=2

DESCRIPTION="BeagleBoard specific xorg configuration file."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND=""

src_install() {
	insinto /etc/X11
	newins "${FILESDIR}/xorg.conf-${PV}" xorg.conf
}
