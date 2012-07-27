# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit toolchain-funcs appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
PROVIDE="virtual/chromeos-bsp"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND=""
DEPEND=""

src_install() {
	doappid "{2EE05B2F-3769-43B9-B78C-792F4A027971}"

	dosbin "${FILESDIR}/activate_date"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"
}
