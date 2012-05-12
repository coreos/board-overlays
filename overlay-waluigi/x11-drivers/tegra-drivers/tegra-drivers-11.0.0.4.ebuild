# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Copyright (c) 2011 NVIDIA Corporation
# Distributed under the terms of the GNU General Public License v2

# The package version (i.e. ${PV}) represents the video driver ABI version of
# the server, plus the version of the LDK that the driver comes from.  For
# example, the X driver for xserver 1.9 (which uses ABI version 8) from LDK
# version 1.2.3 would be tegra-drivers-8.1.2.3.

EAPI="4"

inherit cros-binary versionator

DESCRIPTION="Tegra2 user-land drivers"
HOMEPAGE="http://developer.nvidia.com/linux-tegra"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="arm"
IUSE="hardfp"

DEPEND=""
RDEPEND="sys-apps/nvrm
	=x11-base/xorg-server-1.11*"

S=${WORKDIR}

src_unpack() {
	if use hardfp; then
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/mobile/files/l4t/cardhu_nv-tegra_base_R15-Beta.1.0_armhf.tbz2"
		CROS_BINARY_SUM="2eff40815c47febb61ae6f5a5561b36c4823f4a1"
	else
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/tools/files/l4t/r15_beta/cardhu_Tegra-Linux-R15.beta.1.0_armel.tbz2"
		CROS_BINARY_SUM="bf5f5fab362ee5fdf89f11b11a8883cdb0b6ccd8"
	fi
	cros-binary_src_unpack

	local pkg=${CROS_BINARY_URI##*/}
	ln -s "${CROS_BINARY_STORE_DIR}/${pkg}"
	unpack ./${pkg}
	# Tarballs all the way down!
	use hardfp && unpack $(find -name base.tgz)
}

src_install() {
	local abinum=$(get_major_version)

	insinto /usr/lib/xorg/modules/drivers
	if use hardfp; then
		newins usr/lib/xorg/modules/drivers/tegra_drv.abi${abinum}.so tegra_drv.so
	else
		newins Linux_for_Tegra/nv_tegra/x/tegra_drv.abi${abinum}.so tegra_drv.so
	fi
}
