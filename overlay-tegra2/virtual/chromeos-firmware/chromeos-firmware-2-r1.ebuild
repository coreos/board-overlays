# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Chrome OS Firmware virtual package"
HOMEPAGE="http://src.chromium.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="board_use_tegra2"

# chromeos-firmware-tegra2 depends on a board-specific bct, which should be
# defined in all variants of the tegra2 board. The board_use_tegra2 use flag
# is set for the 'tegra2' board, but it not set in variants of the tegra2
# board. Hence we use this use flag to pick a firmware implementation.
RDEPEND="
	!board_use_tegra2? ( >=chromeos-base/chromeos-firmware-tegra2-0.0.2-r2 )
	board_use_tegra2? ( chromeos-base/chromeos-firmware-null )
	"
