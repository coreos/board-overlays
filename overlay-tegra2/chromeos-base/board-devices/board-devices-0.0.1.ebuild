# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 (meta package)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="tegradbg ath6002 opengles tegra2-ldk"

DEPEND=""
RDEPEND="chromeos-base/board-devices-private
	tegradbg? ( chromeos-base/serial-tty )
	ath6002? ( net-wireless/ath6002 )
	tegra2-ldk? (
		opengles? (
			media-libs/openmax
			media-libs/openmax-codecs )
		x11-drivers/tegra-drivers
	)
	"
