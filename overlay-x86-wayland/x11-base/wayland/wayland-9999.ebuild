# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git autotools

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="http://wayland.freedesktop.org/"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}/${PN}"

LICENSE="CCPL-Attribution-ShareAlike-3.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/expat
	dev-libs/libffi"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
