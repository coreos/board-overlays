# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary OpenGL|ES libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins hardfp"

DEPEND=""
RDEPEND="=sys-apps/nvrm-0.0.24*
	x11-drivers/opengles-headers
	!x11-drivers/opengles"

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://bcs-tegra2-private@git.chromium.org:6222/overlay-tegra2-private"
fi
if use hardfp; then
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/opengles/opengles-hardfp-${PV}.tbz2"
	CROS_BINARY_SUM="23925e57752727642538588023e4d9741c2a6be4"
else
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/opengles/opengles-bin-${PV}.tbz2"
	CROS_BINARY_SUM="80c640c44274b4c611738d2fca00d75e618eb2e6"
fi
