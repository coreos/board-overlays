# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="OpenMAX binary libraries"
SLOT="0"
KEYWORDS="arm"
LICENSE="NVIDIA"

DEPEND=""
RDEPEND="=sys-apps/nvrm-0.0.25*
	media-libs/openmax-codecs
	virtual/opengles"

URI_BASE=${BCS_URI_BASE:="http://developer.download.nvidia.com/assets/tools/files"}
CROS_BINARY_URI="$URI_BASE/l4t/ventana_Tegra-Linux-R12.beta.1.0.tbz2"
CROS_BINARY_SUM="67144b1ef95febbe736f88c8b2b2ad6ad09d6913"

src_install() {
	local target="${CROS_BINARY_STORE_DIR}/${CROS_BINARY_URI##*/}"
	tar xpjf "${target}" -C "${T}" || die "Failed to unpack ${target}"
	tar xpzf "${T}/Linux_for_Tegra/nv_tegra/base.tgz" -C "${T}" || die "Failed to unpack base"

	dolib.so ${T}/usr/lib/libnvomxilclient.so	  	|| die
	dolib.so ${T}/usr/lib/libnvomx.so			|| die
	dosym libnvomx.so /usr/lib/libOmxCore.so		|| die
}
