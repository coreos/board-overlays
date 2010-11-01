# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary OpenGL|ES libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/nvrm
	x11-drivers/opengles-headers"

URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
CROS_BINARY_SUM="14ca120d9f47138ff4e722d914acb66f27400ef2"
