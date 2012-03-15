# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Binary Mali libraries"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

URI_BASE="ssh://bcs-ironhide-private@git.chromium.org:6222/overlay-ironhide-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="7f4ccbd512a9bb1ab4cd375f1f08f08c7a76bae1"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# libmali/usr/lib/libmali.so
