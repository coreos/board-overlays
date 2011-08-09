# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins hardfp"

RDEPEND="chromeos-base/chromeos-init"
DEPEND="${RDEPEND}"

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
fi
if use hardfp; then
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PN}-hardfp-${PV}.tbz2"
	CROS_BINARY_SUM="def3bf3d772f15a7c91b48124244202c68f61850"
else
	CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
	CROS_BINARY_SUM="9c013bc58c35e9cb8944d9df3a6e7e9fe7fb172f"
fi

src_install() {
	insinto /etc/init
	doins ${FILESDIR}/etc/init/nvrm.conf			|| die

	insinto /etc/udev/rules.d
	doins ${FILESDIR}/etc/udev/rules.d/51-nvrm.rules	|| die

	cros-binary_src_install
}
