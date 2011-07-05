# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-fdt

DESCRIPTION="Tegra2 FDT files"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND="sys-boot/chromeos-u-boot"
RDEPEND="${DEPEND}
	"

# U-Boot dts files are installed here
CROS_FDT_ROOT="${ROOT}/u-boot/dts"

# Build all files
CROS_FDT_SOURCES="*"
