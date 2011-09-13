# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary OpenGL|ES libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins hardfp"

DEPEND=""
RDEPEND="sys-apps/nvrm
	x11-drivers/opengles-headers"

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
fi
if use hardfp; then
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PN}-hardfp-${PV}.tbz2"
	CROS_BINARY_SUM="24fd1d51e63dd110024b67ead3d0068b23a661fb"
else
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
	CROS_BINARY_SUM="dbd9db992e995f57e316648dbb657f1c6838be33"
fi
