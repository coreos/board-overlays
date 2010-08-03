# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="OMAP4 Generic (meta package)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="ttydbg"

DEPEND=""
RDEPEND="ttydbg? ( chromeos-base/tty-debug )
	"
