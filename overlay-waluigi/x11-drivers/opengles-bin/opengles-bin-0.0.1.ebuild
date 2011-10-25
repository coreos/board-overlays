# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary OpenGL|ES libraries for Tegra3"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins"

DEPEND=""
RDEPEND="sys-apps/nvrm
	x11-drivers/opengles-headers
	!x11-drivers/opengles"

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private/tegra3"
fi

CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/opengles/opengles-${PV}.tbz2"
CROS_BINARY_SUM="016a2014ec1198c97f27915bee959aa0927454bb"
