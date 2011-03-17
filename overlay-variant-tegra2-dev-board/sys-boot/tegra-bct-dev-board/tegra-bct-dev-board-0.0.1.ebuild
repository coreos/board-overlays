# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit tegra-bct

DESCRIPTION="Dev-Board BCT file"
LICENSE=""
SLOT="0"
KEYWORDS="arm"
IUSE="bootflash-nand"
PROVIDE="virtual/tegra-bct"

RDEPEND=""
DEPEND=""

TEGRA_BCT_SDRAM_CONFIG="sdram.cfg"

if use "bootflash-nand"; then
  TEGRA_BCT_FLASH_CONFIG="nand.cfg"
fi
