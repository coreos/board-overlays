# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 (meta package)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="tegradbg"

DEPEND=""
RDEPEND="chromeos-base/board-devices-private
	tegradbg? ( chromeos-base/tegra-debug )
	"
