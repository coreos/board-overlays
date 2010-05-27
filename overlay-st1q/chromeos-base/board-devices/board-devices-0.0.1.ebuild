# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="ST1Q Board (meta package)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"
IUSE="X"

RDEPEND="chromeos-base/board-devices-private
	media-libs/mm-audio-oss
	media-libs/mm-core-oss
	media-libs/mm-video-oss
	sys-boot/qsd-modem"

