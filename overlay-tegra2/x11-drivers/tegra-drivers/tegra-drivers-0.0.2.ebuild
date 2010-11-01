# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Tegra2 user-land drivers"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/nvrm"

URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
CROS_BINARY_SUM="668aaf8f4d6bab76e0273c4a98e48e92d9d3b9c9"
