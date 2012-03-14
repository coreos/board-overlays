# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Multi-Format Codec Firmware Binary for Exynos5"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

URI_BASE="ssh://bcs-ironhide-private@git.chromium.org:6222/overlay-ironhide-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="13707bfb5ba05a7632447f6947dc327c583a6865"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# mfc-fw/lib/firmware/mfc_fw.bin
