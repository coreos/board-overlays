# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit unpacker

DESCRIPTION="Mali drivers, binary only install"
HOMEPAGE="http://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices/samsung-arm-chromebook"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/mali-drivers-${PVR}.run"

LICENSE="Google-TOS"
SLOT="0"
KEYWORDS="arm"

DEPEND=""

RDEPEND="!media-libs/mali-drivers
	x11-base/xorg-server
	x11-drivers/xf86-video-armsoc
	!x11-drivers/opengles"

S=${WORKDIR}

src_install() {
	cp -pPR "${S}"/* "${D}/" || die "Install failed!"
}
