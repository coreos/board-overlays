# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2

DESCRIPTION="X.Org xkbcommon library"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-proto/xproto
	>=x11-proto/kbproto-1.0.5"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		--with-xkb-config-root=/usr/share/X11/xkb
	)
}

src_prepare() {
	echo "CFLAGS =" >> ${S}/makekeys/Makefile.am
	xorg-2_src_prepare
}
