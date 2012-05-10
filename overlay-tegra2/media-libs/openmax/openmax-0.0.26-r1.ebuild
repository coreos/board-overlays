# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="OpenMAX binary libraries"
SLOT="0"
KEYWORDS="arm"
IUSE="hardfp"
LICENSE="NVIDIA"

DEPEND=""
RDEPEND="=sys-apps/nvrm-0.0.26*
	media-libs/openmax-codecs
	virtual/opengles"

src_unpack() {
	if use hardfp; then
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/mobile/files/l4t/ventana_nv-tegra_base_R15-Beta.1.0_armhf.tbz2"
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
	else
		tar xpzf "${T}/Linux_for_Tegra/nv_tegra/base.tgz" -C "${T}" || die "Failed to unpack base"
	fi

	dolib.so ${T}/usr/lib/libnvomxilclient.so	  	|| die
	dolib.so ${T}/usr/lib/libnvomx.so			|| die
	dosym libnvomx.so /usr/lib/libOmxCore.so		|| die
}
