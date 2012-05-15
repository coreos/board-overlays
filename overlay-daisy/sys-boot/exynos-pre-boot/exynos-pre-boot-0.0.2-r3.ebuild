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

URI_BASE="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles"
CROS_BINARY_URI="${URI_BASE}/${PF}.tbz2"
CROS_BINARY_SUM="9f33f1bb2bf57db5caf8f031bb7684ee9320aee8"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# exynos-pre-boot/firmware/E5250.nbl1.bin
