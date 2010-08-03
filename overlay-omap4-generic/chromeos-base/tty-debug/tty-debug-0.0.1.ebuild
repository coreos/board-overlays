# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="tty debug settings"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND="chromeos-base/chromeos-init"
RDEPEND="${DEPEND}
         sys-apps/upstart"

src_install() {
    # Install Upstart configuration files.
    insinto /etc/init
    doins "${FILESDIR}"/etc/init/ttyO2.conf
    
    DEVICES_DIR="/lib/chromiumos/devices"
    dodir "${DEVICES_DIR}"
    mknod --mode=0600 "${D}/${DEVICES_DIR}/ttyO2"  c 252 2
    chown root.tty "${D}/${DEVICES_DIR}"/tty*
}
