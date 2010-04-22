# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

if [[ -z "${ST1Q_SOURCES_QUALCOMM}" ]] ; then
	inherit git

	EGIT_REPO_URI="http://src.chromium.org/git/mm-core.git"
	EGIT_COMMIT="ad19d464d0bffba3d45cd92c53e196c354dfd823"
else
	files="${CHROMEOS_ROOT}/${ST1Q_SOURCES_QUALCOMM}/omx/mm-core"
fi

inherit toolchain-funcs

DESCRIPTION="omx multi-media core libraries"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND=""
DEPEND="chromeos-base/kernel-headers"

src_unpack() {
	if [[ -n "${EGIT_REPO_URI}" ]] ; then
		git_src_unpack
	else
		elog "Using source: ${files}"
		mkdir -p "${S}"
		cp -a "${files}"/* "${S}" || die "mm-core copy failed"
		cd "${S}" || die "cd failed"
	fi
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
