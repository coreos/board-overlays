# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="QSD Modem header creation"
HOMEPAGE=""
LICENSE=""
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND="sys-boot/u-boot"
RDEPEND="${DEPEND}"

src_compile() {
	local image=${SYSROOT}"/u-boot/u-boot.bin"
	local mkappsboot="${FILESDIR}/mkappsboot.py"

	if [ ! -f "${image}" ]; then
		die "U-Boot image ${image} missing."
	fi

	if [ ! -x "${mkappsboot}" ]; then
		die "Tool ${mkappsboot} needed to create qsd modem header missing."
	fi

	"${mkappsboot}" "${image}" "${APPSBOOT}"\
		"${CHROMEOS_U_BOOT_TEXT_BASE}" || die "Failed to create header"
}

src_install() {
	insinto /u-boot

	doins "${APPSBOOT}"
}
