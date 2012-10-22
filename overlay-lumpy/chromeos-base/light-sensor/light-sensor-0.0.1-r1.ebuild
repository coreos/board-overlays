# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Board specific light sensor configuration files"
HOMEPAGE="http://src.chromium.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""

# Prevent file conflicts with the old revisions of power_manager.
RDEPEND="${RDEPEND}
	!<=chromeos-base/power_manager-0.0.1-r165
"

src_install() {
	# Install light sensor tuning script.
	exeinto "/lib/udev"
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install light sensor udev rules.
	insinto "/lib/udev/rules.d"
	doins "${FILESDIR}/99-light-sensor.rules"
}
