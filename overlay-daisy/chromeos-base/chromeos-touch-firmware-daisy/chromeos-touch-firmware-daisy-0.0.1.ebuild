# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit cros-binary

DESCRIPTION="Chromeos touchpad firmware updater and firmware payload."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"

DEPEND=""

RDEPEND="${DEPEND}
"

URI_BASE="ssh://bcs-daisy-private@git.chromium.org:6222/overlay-daisy-private"

PRODUCT_ID="CYTRA-116002-00"
FIRMWARE_VERSION="2.3"

CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="30a82700c75ad6487cb9f8e8bd1061bed94adf1d"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

FW_NAME="${PRODUCT_ID}_${FIRMWARE_VERSION}.bin"
SYM_LINK_PATH="/lib/firmware/cyapa.bin"

S=${WORKDIR}

src_install() {
	cros-binary_src_install

	exeinto /opt/google/touchpad/firmware
	exeopts -m0700
	doexe "${FILESDIR}/chromeos-touch-firmwareupdate.sh"

	# Create symlink at /lib/firmware to the firmware binary.
	dosym "/opt/google/touchpad/firmware/${FW_NAME}" "${SYM_LINK_PATH}"

	# Install upstart conf for updater
	insinto "/etc/init"
	doins "${FILESDIR}/chromeos-touch-firmwareupdate.conf"
}
