# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Init script to run agetty on the serial port"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/upstart"

# We can't use the normal serial-tty because the current kernel puts the
# useful TTY on /dev/ttySAC3.  TODO: Can we get the kernel to put the right
# TTY on /dev/ttyS0 and then remove this script?
src_install() {
	insinto /etc/init
	doins "${FILESDIR}"/ttySAC3.conf || die
}
