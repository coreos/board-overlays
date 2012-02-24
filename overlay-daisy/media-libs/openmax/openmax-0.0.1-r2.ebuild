# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Binary OpenMax libraries for ironhide"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="!chromeos-base/exynos-omx
	${DEPEND}"

URI_BASE="ssh://bcs-ironhide-private@git.chromium.org:6222/overlay-ironhide-private"
BINARY_TAR_FILE="${PF}.tbz2"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${BINARY_TAR_FILE}"
CROS_BINARY_SUM="09f885a6f4a49b3a74917121c130c9650e2282bf"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"
