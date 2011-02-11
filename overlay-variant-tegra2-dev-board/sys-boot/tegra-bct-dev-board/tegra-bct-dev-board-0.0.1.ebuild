# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Dev-Board BCT file"
LICENSE=""
SLOT="0"
KEYWORDS="arm"
IUSE=""
PROVIDE="virtual/tegra-bct"

RDEPEND=""
DEPEND=""

BCT="harmony_a02_12Mhz_H5PS1G83EFR-S5C_333Mhz_1GB_2K8Nand_HY27UF084G2B-TP.bct"

src_install() {
	dodir /u-boot
	insinto /u-boot

	newins "${FILESDIR}/${BCT}" "board.bct"
}
