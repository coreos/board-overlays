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
FIRMWARE_VERSION="2.4"

CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="a2c5a9f606293453466eed4050c4f1d7aa1bd447"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

FW_NAME="${PRODUCT_ID}_${FIRMWARE_VERSION}.bin"
SYM_LINK_PATH="/lib/firmware/cyapa.bin"

TRIAL1_FW_NAME="${PRODUCT_ID}_2.7.bin"
TRIAL2_FW_NAME="${PRODUCT_ID}_2.8.bin"
TRIAL3_FW_NAME="${PRODUCT_ID}_2.9.bin"
TRIAL1_SYM_LINK_PATH="/lib/firmware/cyapa.bin-trial1"
TRIAL2_SYM_LINK_PATH="/lib/firmware/cyapa.bin-trial2"
TRIAL3_SYM_LINK_PATH="/lib/firmware/cyapa.bin-trial3"

S=${WORKDIR}

src_install() {
	cros-binary_src_install

	exeinto /opt/google/touchpad/firmware
	exeopts -m0700
	doexe "${FILESDIR}/chromeos-touch-firmwareupdate.sh"

	# Install choices file for trial firmware switching
	insinto /opt/google/touchpad/firmware
	doins "${FILESDIR}/choices"

	# Create symlink at /lib/firmware to the firmware binary.
	dosym "/opt/google/touchpad/firmware/${FW_NAME}" "${SYM_LINK_PATH}"

	dosym "/opt/google/touchpad/firmware/${TRIAL1_FW_NAME}" "${TRIAL1_SYM_LINK_PATH}"
	dosym "/opt/google/touchpad/firmware/${TRIAL2_FW_NAME}" "${TRIAL2_SYM_LINK_PATH}"
	dosym "/opt/google/touchpad/firmware/${TRIAL3_FW_NAME}" "${TRIAL3_SYM_LINK_PATH}"

	# Install upstart conf for updater
	insinto "/etc/init"
	doins "${FILESDIR}/chromeos-touch-firmwareupdate.conf"
}
