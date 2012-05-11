# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit cros-binary

DESCRIPTION="NVIDIA binary OpenGL|ES libraries for Tegra2"
HOMEPAGE="http://developer.nvidia.com/linux-tegra"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="arm"
IUSE="hardfp"

DEPEND=""
RDEPEND="sys-apps/nvrm
	x11-drivers/opengles-headers
	!x11-drivers/opengles"

S=${WORKDIR}

src_unpack() {
	if use hardfp; then
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/mobile/files/l4t/ventana_nv-tegra_base_R15-Beta.1.0_armhf.tbz2"
		CROS_BINARY_SUM="782dec54c15138456496aac6db050469d4befa28"
	else
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/tools/files/l4t/r15_beta/ventana_Tegra-Linux-R15.beta.1.0_armel.tbz2"
		CROS_BINARY_SUM="93a2024b554b13cbf12218301c7652091de0aea3"
	fi
	cros-binary_src_unpack

	local pkg=${CROS_BINARY_URI##*/}
	ln -s "${CROS_BINARY_STORE_DIR}/${pkg}"
	unpack ./${pkg}
	# Tarballs all the way down!
	unpack $(find -name base.tgz)
}

src_install() {
	newlib.so usr/lib/libEGL.so libEGL.so.1
	dosym libEGL.so.1 /usr/lib/libEGL.so

	newlib.so usr/lib/libGLESv2.so libGLESv2.so.2
	dosym libGLESv2.so.2 /usr/lib/libGLESv2.so
}
