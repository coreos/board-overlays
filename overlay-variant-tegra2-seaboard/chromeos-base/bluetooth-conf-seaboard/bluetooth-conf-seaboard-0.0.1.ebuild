# Copyright (c) 2010-2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Tegra2 seaboard overlay specific bluetooth setup configuration file."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="bluetooth"

RDEPEND="net-wireless/bluez
         net-wireless/ath3k"
DEPEND=${RDEPEND}

# Bluetooth chip AR3002 on seaboard uses UART to interface with Tegra host.
# UART-HCI driver is needed to make AR3002 communicate with bluetooth daemon.
# We setup a upstart job in bluetooth-uart.conf to load the driver.
# The UART-HCI driver hciattach is from package net-wireless/bluez and the
# firmware for AR3002 is from package net-wireless/ath3k.

src_install() {
	if use bluetooth; then
		insinto	 /etc/init
		doins ${FILESDIR}/bluetooth-uart.conf || die
	fi
}
