# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="OpenMAX binary libraries"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins hardfp"

DEPEND=""
RDEPEND="sys-apps/nvrm
	virtual/opengles"


if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
fi
if use hardfp; then
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PN}-hardfp-${PV}.tbz2"
	CROS_BINARY_SUM="6384da6eab6ca26c953702ba8b45c354c143f189"
else
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
	CROS_BINARY_SUM="d1eb6bdf073e673f4f29e98897b34f982ea23c24"
fi
