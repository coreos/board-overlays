# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Mali X11 drivers"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="
	x11-drivers/libmali
"

URI_BASE="ssh://bcs-ironhide-private@git.chromium.org:6222/overlay-ironhide-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="b11ebb4fc99c240637efc62d14fe7017514b213f"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# mali-drivers/usr/lib/xorg/modules/drivers/mali_drv.so
