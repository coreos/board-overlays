# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Virtual for OpenGLES implementations"
SRC_URI=""

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="tegra-ldk hardfp"

RDEPEND="
	!tegra-ldk? ( x11-drivers/opengles )
	tegra-ldk? (
		!hardfp? ( x11-drivers/opengles-bin )
		hardfp? ( =x11-drivers/opengles-bin-0.0.24* )
	)
	"
DEPEND=""
