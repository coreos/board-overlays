# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Binary pre-bootloader for ironhide"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND=""

URI_BASE="ssh://bcs-ironhide-private@git.chromium.org:6222/overlay-ironhide-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="5a2a5cdf2c8e87404e867b036f831e7175aa6637"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# exynos-pre-boot/firmware/E5250.nbl1.bin
