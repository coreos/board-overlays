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
	x11-drivers/opengles-headers
	!x11-drivers/opengles"

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://bcs-tegra2-private@git.chromium.org:6222/overlay-tegra2-private"
fi
if use hardfp; then
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/opengles-hardfp-${PVR}.tbz2"
	CROS_BINARY_SUM="aabbf78b2223996cc54330d2ea196885b68809bc"
else
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/opengles-bin-${PVR}.tbz2"
	CROS_BINARY_SUM="6b766c01ace1ee935a19c6c2b03cf18f66a7edf6"
fi
