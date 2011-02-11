# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Seaboard BCT file"
LICENSE=""
SLOT="0"
KEYWORDS="arm"
IUSE=""
PROVIDE="virtual/tegra-bct"

RDEPEND=""
DEPEND=""

src_install() {
	dodir /u-boot
	insinto /u-boot

	newins "${FILESDIR}/spi512.bct" "board.bct"
}
