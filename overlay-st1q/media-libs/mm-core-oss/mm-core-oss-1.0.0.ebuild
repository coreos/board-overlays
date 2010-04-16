# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit git toolchain-funcs

DESCRIPTION="omx multi-media core libraries"
EGIT_REPO_URI="http://src.chromium.org/git/mm-core.git"
EGIT_COMMIT="ad19d464d0bffba3d45cd92c53e196c354dfd823"
HOMEPAGE="http://src.chromium.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND=""
DEPEND="chromeos-base/kernel-headers"

files="${CHROMEOS_ROOT}/src/third_party/omx/mm-core"

src_unpack() {
	git_src_unpack
}

src_compile() {
	if tc-is-cross-compiler ; then
		tc-getCC
		tc-getCXX
	fi

	emake CC="${CC}" CCC="${CXX}" LIBVER=${PV} || die "mm-core compile failed"
}

src_install() {
	emake DESTDIR="${D}" LIBVER=${PV} install || die "Install failed"
}
