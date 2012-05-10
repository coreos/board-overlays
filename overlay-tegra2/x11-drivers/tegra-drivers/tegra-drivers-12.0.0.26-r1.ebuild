# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Copyright (c) 2011 NVIDIA Corporation
# Distributed under the terms of the GNU General Public License v2

# The package version (i.e. ${PV}) represents the video driver ABI version of
# the server, plus the version of the LDK that the driver comes from.  For
# example, the X driver for xserver 1.9 (which uses ABI version 8) from LDK
# version 1.2.3 would be tegra-drivers-8.1.2.3.

EAPI=2

inherit cros-binary

DESCRIPTION="Tegra2 user-land drivers"
SLOT="0"
KEYWORDS="arm"
IUSE="hardfp"
LICENSE="NVIDIA"

DEPEND=""
RDEPEND="sys-apps/nvrm
        >=x11-base/xorg-server-1.12
        <x11-base/xorg-server-1.13"

ABI=`echo "${PV}" | cut -d. -f1`


src_unpack() {
	if use hardfp; then
		CROS_BINARY_URI="http://developer.nvidia.com/sites/default/files/akamai/mobile/files/l4t/ventana_nv-tegra_base_R15-Beta.1.0_armhf.tbz2"
		CROS_BINARY_SUM="782dec54c15138456496aac6db050469d4befa28"
	else
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/tools/files/l4t/r15_beta/ventana_Tegra-Linux-R15.beta.1.0_armel.tbz2"
		CROS_BINARY_SUM="93a2024b554b13cbf12218301c7652091de0aea3"
	fi
	cros-binary_src_unpack
}

src_install() {
	local target="${CROS_BINARY_STORE_DIR}/${CROS_BINARY_URI##*/}"
	tar xpjf "${target}" -C "${T}" || die "Failed to unpack ${target}"

	if use hardfp; then
		tar xpzf "${T}/base.tgz" -C "${T}" || die "Failed to unpack base"

		insinto /usr/lib/xorg/modules/drivers
		newins ${T}/usr/lib/xorg/modules/drivers/tegra_drv.abi${ABI}.so tegra_drv.so	|| die
	else

		insinto /usr/lib/xorg/modules/drivers
		newins ${T}/Linux_for_Tegra/nv_tegra/x/tegra_drv.abi${ABI}.so tegra_drv.so	|| die
	fi

	fperms 0644 /usr/lib/xorg/modules/drivers/tegra_drv.so	      			|| die

}
