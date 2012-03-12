# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit tegra-bct

DESCRIPTION="Waluigi BCT file"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="arm"
IUSE="bootflash-spi tegra30-bct"
PROVIDE="virtual/tegra-bct"

RDEPEND=""
DEPEND=""

if use bootflash-spi; then
	TEGRA_BCT_FLASH_CONFIG="spi.cfg"
fi

TEGRA_BCT_SDRAM_CONFIG="waluigi-sdram.cfg"
TEGRA_BCT_CHIP_FAMILY="t30"
