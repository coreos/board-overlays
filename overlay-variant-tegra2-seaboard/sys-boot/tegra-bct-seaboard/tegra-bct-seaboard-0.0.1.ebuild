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

if use "bootflash-nand"; then
  TEGRA_BCT_FLASH_CONFIG="nand.cfg"
  TEGRA_BCT_SDRAM_CONFIG="sdram-nand.cfg"

elif use "bootflash-spi"; then
  TEGRA_BCT_FLASH_CONFIG="spi.cfg"
  TEGRA_BCT_SDRAM_CONFIG="sdram-spi.cfg"
fi
