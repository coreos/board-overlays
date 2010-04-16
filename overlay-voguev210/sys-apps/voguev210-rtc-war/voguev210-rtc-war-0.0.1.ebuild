# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Vogue V210 RTC workaround"
SLOT="0"
KEYWORDS="arm"
IUSE=""

src_install() {
  insinto /etc/init
  doins ${FILESDIR}/date-start.conf
  doins ${FILESDIR}/date-stop.conf
}
