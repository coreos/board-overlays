# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

# For now, we will use a precompiled kernel. At some point, we'll add a
# suitable Beagleboard kernel build. Until then, this ebuild pretends to
# compile a kernel.

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Chrome OS Kernel"
HOMEPAGE="http://src.chromium.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm x86"
IUSE=""

DEPEND=""
RDEPEND=""

kernel=${CHROMEOS_KERNEL:-"kernel/files"}
files="${CHROMEOS_ROOT}/src/third_party/${kernel}"
config="none"

src_unpack() {
	elog "Faking unpack"
}

src_configure() {
	elog "Faking configure"
}

src_compile() {
	elog "Faking compile"
}

src_install() {
	elog "Faking install"
}
