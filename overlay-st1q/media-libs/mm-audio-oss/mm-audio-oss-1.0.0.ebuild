# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit git toolchain-funcs

DESCRIPTION="omx multi-media audio libraries"
EGIT_REPO_URI="http://src.chromium.org/git/mm-audio.git"
EGIT_COMMIT="09a734cb9d10fbb243fe086961445e78d891f5a2"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="media-libs/mm-core-oss"
DEPEND="${RDEPEND}
	chromeos-base/kernel-headers"

files="${CHROMEOS_ROOT}/src/third_party/omx/mm-audio"

src_unpack() {
	git_src_unpack
}

src_compile() {
	if tc-is-cross-compiler ; then
		tc-getCC
		tc-getCXX
	fi

	emake CC="${CC}" CCC="${CXX}" LIBVER=${PV} \
		|| die "mm-audio compile failed"
}

src_install(){
	emake DESTDIR="${D}" LIBVER=${PV} install || die "mm-audio install failed"
}
