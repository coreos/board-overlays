# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit eutils git toolchain-funcs

DESCRIPTION="X-Loader: Initial Program Loader for OMAP-based boards"
EGIT_REPO_URI="http://git.gitorious.org/x-load-omap3/mainline.git"
EGIT_TREE="5eae9fb96b90370c7e11b757e6de3ac0df4dfd51"
HOMEPAGE="http://www.sakoman.net/cgi-bin/gitweb.cgi?p=x-load-omap3.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"
IUSE="fastboot"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	if use fastboot ; then
		epatch "${FILESDIR}/${P}-fastboot.patch"
	fi
	# http://beagleboard.googlecode.com/files/signGP.c
	cp "${FILESDIR}"/signGP.c "${S}"
}

src_configure() {
	local configuration="omap3530beagle_config"

	elog "Using X-Loader config: ${configuration}"

	emake distclean
	emake "${configuration}" \
		|| die "X-Loader configuration failed"
}

src_compile() {
	emake \
		ARCH=$(tc-arch-kernel) \
		CROSS_COMPILE="${CHOST}-" \
		|| die "X-Loader compile failed"
	"$(tc-getBUILD_CC)" -o signGP signGP.c \
		|| die "signGP compile failed"
	./signGP x-load.bin
}

src_install() {
	dodir /boot
	cp -a "${S}"/x-load.bin.ift "${D}"/boot/
}
