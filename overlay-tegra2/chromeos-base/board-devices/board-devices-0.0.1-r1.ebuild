# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 (meta package)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="tegradbg ath6002 opengles tegra-ldk hardfp"

DEPEND=""
RDEPEND="chromeos-base/board-devices-private
	tegradbg? ( chromeos-base/serial-tty )
	ath6002? ( net-wireless/ath6002 )
	tegra-ldk? (
		opengles? (
			hardfp? ( =media-libs/openmax-0.0.24* )
			!hardfp? ( media-libs/openmax )
		)
		hardfp? ( =x11-drivers/tegra-drivers-8.0.0.24* )
		!hardfp? ( x11-drivers/tegra-drivers )
	)
	"
