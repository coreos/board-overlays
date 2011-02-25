# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit tegra-bct

DESCRIPTION="Seaboard BCT file"
LICENSE=""
SLOT="0"
KEYWORDS="arm"
IUSE="bootflash-nand bootflash-spi"
PROVIDE="virtual/tegra-bct"

RDEPEND=""
DEPEND=""

TEGRA_BCT_FILE="Seaboard_A02P_MID_1GB_HYNIX_H5PS2G83AFR-S6_ddr2_333Mhz_NAND.bct"

if use "bootflash-nand"; then
  TEGRA_BCT_FLASH_CONFIG="nand.cfg"
elif use "bootflash-spi"; then
  TEGRA_BCT_FLASH_CONFIG="spi.cfg"
fi
