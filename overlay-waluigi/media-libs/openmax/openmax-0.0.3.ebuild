# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="OpenMAX binary libraries"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins"

DEPEND=""
RDEPEND="sys-apps/nvrm
	virtual/opengles"


if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://bcs-tegra2-private@git.chromium.org:6222/overlay-tegra2-private/tegra3"
fi
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
CROS_BINARY_SUM="72d4238606684310f3e9d58378d0ca11aa78451a"
