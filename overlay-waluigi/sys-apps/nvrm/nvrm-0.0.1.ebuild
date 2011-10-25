# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra3"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins"

RDEPEND="chromeos-base/chromeos-init"
DEPEND="${RDEPEND}"

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private/tegra3"
fi
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
CROS_BINARY_SUM="efa97915fa2711375dabeb56758b268f6ede48d1"

src_install() {
	insinto /etc/udev/rules.d
	doins ${FILESDIR}/etc/udev/rules.d/51-nvrm.rules	|| die

	cros-binary_src_install
}
