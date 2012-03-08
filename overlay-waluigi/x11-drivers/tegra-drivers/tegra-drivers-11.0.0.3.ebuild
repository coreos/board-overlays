# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Copyright (c) 2011 NVIDIA Corporation
# Distributed under the terms of the GNU General Public License v2

# The package version (i.e. ${PV}) represents the video driver ABI version of
# the server, plus the version of the LDK that the driver comes from.  For
# example, the X driver for xserver 1.9 (which uses ABI version 8) from LDK
# version 1.2.3 would be tegra-drivers-8.1.2.3.

EAPI=2

inherit cros-binary

DESCRIPTION="Tegra3 user-land drivers"
SLOT="0"
KEYWORDS="~arm"
IUSE="tegra-local-bins"

DEPEND=""
RDEPEND="sys-apps/nvrm
        >=x11-base/xorg-server-1.11
        <x11-base/xorg-server-1.12"

ABI=`echo "${PV}" | cut -d. -f1`
LDK=`echo "${PV}" | cut -d. -f2-`

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://bcs-tegra2-private@git.chromium.org:6222/overlay-tegra2-private/tegra3"
fi
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PN}-abi${ABI}-${LDK}.tbz2"
CROS_BINARY_SUM="1cd16ef34bd7fce02f6dad7dc6f4fa394c96c914"
