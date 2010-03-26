# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Vogue V210 eth0 MAC handling"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND="sys-apps/uboot-env"
RDEPEND="${DEPEND}"

src_install() {
  dobin ${FILESDIR}/setup_mac

  dodir lib/chromiumos/devices
  mknod "${D}/lib/chromiumos/devices/mtdblock0" b 31 0

  insinto /etc/init
  doins ${FILESDIR}/voguev210-mac.conf
}
