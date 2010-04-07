# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="QSD Modem header creation"
HOMEPAGE=""
LICENSE=""
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND="sys-boot/u-boot"
RDEPEND="${DEPEND}"

src_compile() {
	local image="${ROOT}/u-boot/u-boot.bin"
	local tools="${CHROMEOS_ROOT}/src/third_party/u-boot/files/tools"
	local mkappsboot="${tools}/qualcomm/mkappsboot.py"

	if [ ! -f "${image}" ]; then
		die "U-Boot image ${image} missing."
	fi

	if [ ! -x "${mkappsboot}" ]; then
		die "U-Boot tool ${mkappsboot} missing."
	fi

	"${mkappsboot}" "${image}" appsboot.mbn || die "Failed to create header"
}

src_install() {
	insinto /u-boot

	doins appsboot.mbn
}
