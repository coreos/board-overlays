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
	URI_BASE="ssh://bcs-tegra2-private@git.chromium.org:6222/overlay-tegra2-private/tegra3"
fi
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="edabad6fedf40bccbe40740e08312eee9c340906"

src_install() {
	insinto /etc/udev/rules.d
	doins ${FILESDIR}/etc/udev/rules.d/51-nvrm.rules	|| die

	cros-binary_src_install
}
