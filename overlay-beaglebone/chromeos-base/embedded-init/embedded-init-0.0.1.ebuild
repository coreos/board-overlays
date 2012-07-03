# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Upstart jobs for the Chrome OS embedded image"
HOMEPAGE="http://www.chromium.org/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""

RDEPEND="chromeos-base/chromeos-init
	sys-apps/coreutils
	sys-apps/module-init-tools
	sys-apps/upstart
	sys-process/procps
	"

src_install() {
	dodir /etc/init
	insinto /etc/init
	doins ${FILESDIR}/servod.conf
}

modify_upstart() {
	local upstart_file="$1"
	local new_rules="$2"
	local upstart_path="${ROOT}/etc/init/${upstart_file}"

	if [ ! -f "$upstart_path" ]; then
		ewarn "Ignore non-exist upstart file: ${upstart_file}"
		return
	fi

	grep -q "^start on " "${upstart_path}" ||
		die "Unknown format in upstart file: ${upstart_file}"

	sed -i "s/^start on .*/start on $new_rules/" "${upstart_path}" ||
		die "Failed to modify upstart file: ${upstart_file}"
}

disable_upstart() {
	modify_upstart "$1" "never"
}

pkg_postinst() {
	disable_upstart "ui.conf"
	disable_upstart "power.conf"
	disable_upstart "powerd.conf"
	disable_upstart "powerm.conf"
	disable_upstart "disable_echo.conf"

	modify_upstart "boot-complete.conf" "started boot-services"
	modify_upstart "update-engine.conf" "starting failsafe"
	sed -i 's/#for_test //' "${ROOT}/etc/init/openssh-server.conf"
}
