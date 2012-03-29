# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Waluigi bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="opengles tegra3-ldk"
PROVIDE="virtual/chromeos-bsp"

# TODO(dianders):
# - Add any touchpad files needed for waluigi (AKA 50-touchpad-cmt-waluigi.conf)

DEPEND=""
RDEPEND="
	chromeos-base/serial-tty
	tegra3-ldk? (
		opengles? ( media-libs/openmax )
		x11-drivers/tegra-drivers
	)
"

src_install() {
	# Override default CPU clock speed governor
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/cpufreq.conf" || die "installation failed ($?)"
}
