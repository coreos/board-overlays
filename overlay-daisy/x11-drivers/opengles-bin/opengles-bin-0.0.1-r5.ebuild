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
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="eb9ca9238a8115fe6d4cd4f315af72f601dae6af"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# opengles-bin/usr/lib/libGLESv2.so.2
# opengles-bin/usr/lib/libGLESv2.so
# opengles-bin/usr/lib/libEGL.so
# opengles-bin/usr/lib/libEGL.so.1
