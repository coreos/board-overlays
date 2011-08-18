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
	x11-drivers/opengles"


if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
fi
if use hardfp; then
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PN}-hardfp-${PV}.tbz2"
	CROS_BINARY_SUM="83e70fe20de5e2e5622a0b625b46a5897ca39421"
else
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
	CROS_BINARY_SUM="5f0d16175d46705280328d2f94eb75f476f4838b"
fi
