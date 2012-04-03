# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
CROS_WORKON_COMMIT="eae3bcb4ccb80ef1c4dcd2f71987c1187aeb9e73"
CROS_WORKON_TREE="a6d959f0bc06a9fcc6f0d5e50a663a743094e447"

EAPI=4
CROS_WORKON_PROJECT="chromiumos/third_party/wayland"

inherit autotools cros-workon toolchain-funcs

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="http://wayland.freedesktop.org/"

LICENSE="CCPL-Attribution-ShareAlike-3.0 MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

RDEPEND="dev-libs/expat
	dev-libs/libffi"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	if tc-is-cross-compiler ; then
		econf $(use_enable static-libs static) --disable-scanner
	else
		econf $(use_enable static-libs static)
	fi
}
