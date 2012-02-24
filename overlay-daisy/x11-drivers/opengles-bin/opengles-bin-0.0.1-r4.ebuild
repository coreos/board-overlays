# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Binary OpenGLES libraries for ironhide"
SLOT="0"
KEYWORDS="arm"
IUSE=""

# TODO(dianders): Shouldn't opengles-headers be DEPEND
# not RDEPEND?
DEPEND=""
RDEPEND="
	x11-drivers/opengles-headers
	x11-drivers/libmali
        !x11-drivers/opengles
"

URI_BASE="ssh://bcs-ironhide-private@git.chromium.org:6222/overlay-ironhide-private"
BINARY_TAR_FILE="${PF}.tbz2"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${BINARY_TAR_FILE}"
CROS_BINARY_SUM="c8ea97d916e7c1d26ed9efb150ece45e28dc987e"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"
