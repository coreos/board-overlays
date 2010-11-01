# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="chromeos-base/chromeos-init"
DEPEND="${RDEPEND}"

URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
CROS_BINARY_SUM="9cdeb319da3b4362385e62bd214e433eeebbfe5c"

src_install() {
	insinto /etc/init
	doins ${FILESDIR}/etc/init/nvrm.conf			|| die

	insinto /etc/udev/rules.d
	doins ${FILESDIR}/etc/udev/rules.d/51-nvrm.rules	|| die

	cros-binary_src_install
}
