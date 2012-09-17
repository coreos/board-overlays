# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Daisy public bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="-snow -samsung_serial"
PROVIDE="virtual/chromeos-bsp"

DEPEND=""
RDEPEND="
	!<chromeos-base/chromeos-bsp-daisy-private-0.0.1-r11
	snow? ( chromeos-base/chromeos-init )
	samsung_serial? ( chromeos-base/serial-tty )
	media-libs/media-rules
	media-libs/mfc-fw
	sys-boot/exynos-pre-boot
	x11-drivers/xf86-video-armsoc
"

src_install() {
	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/wakeup_input_device_names" || die
	doins "${FILESDIR}/low_battery_shutdown_percent" || die
	doins "${FILESDIR}/low_battery_shutdown_time_s" || die

	# Install platform specific usb device list for laptop mode tools
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/usb-autosuspend.conf" || die "installation failed ($?)"
	doins "${FILESDIR}/cpufreq.conf" || die "installation failed ($?)"

	if use snow; then
		# Install platform specific config file for thermal monitoring
		dosbin "${FILESDIR}/thermal.sh" || die "installation failed ($?)"
		insinto "/etc/init/"
		doins "${FILESDIR}/thermal.conf" || die "installation failed ($?)"
	fi
}
