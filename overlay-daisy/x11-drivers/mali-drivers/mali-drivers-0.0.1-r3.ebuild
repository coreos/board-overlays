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
BINARY_TAR_FILE="${PF}.tbz2"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${BINARY_TAR_FILE}"
CROS_BINARY_SUM="2123597c09256734c1d66ff712e444b6486c1628"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"
