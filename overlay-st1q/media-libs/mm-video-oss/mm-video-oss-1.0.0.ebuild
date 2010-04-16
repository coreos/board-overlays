# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit git toolchain-funcs

DESCRIPTION="omx multi-media video libraries"
EGIT_REPO_URI="http://src.chromium.org/git/mm-video.git"
EGIT_COMMIT="b40bf673b704683504ee91b6d96ed6875b1c6177"
HOMEPAGE="http://src.chromium.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="media-libs/mm-core-oss"
DEPEND="${RDEPEND}
	chromeos-base/kernel-headers"

files="${CHROMEOS_ROOT}/src/third_party/omx/mm-video"

src_unpack() {
	git_src_unpack
}

src_compile() {
	if tc-is-cross-compiler ; then
		tc-getCC
		tc-getCXX
	fi

	emake CC="${CC}" CCC="${CXX}" LIBVER=${PV} \
		|| die "mm-video compile failed"
	cd "${S}" || die "cd failed"
}

src_install() {
	emake DESTDIR="${D}" LIBVER=${PV} install || die "mm-video install failed"
}
