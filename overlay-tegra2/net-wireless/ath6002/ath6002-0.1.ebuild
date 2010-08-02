# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils

DESCRIPTION="Atheros AR6002 firmware"
HOMEPAGE="http://www.atheros.com/"
LICENSE="Atheros"

SLOT="0"
KEYWORDS="arm"
IUSE=""

#RESTRICT="binchecks strip test"

DEPEND=""
RDEPEND=""

src_install() {
    dodir /lib/firmware || die
    cp -ar "${FILESDIR}/"* "${D}"/lib/firmware || die
}
