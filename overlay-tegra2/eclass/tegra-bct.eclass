# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

#
# Original Author: The Chromium OS Authors <chromium-os-dev@chromium.org>
# Purpose: Install Tegra BCT files for firmware construction.
#

# @ECLASS-VARIABLE: TEGRA_BCT_FILE
# @DESCRIPTION:
# BCT file to install
: ${TEGRA_BCT_FILE:=}

# @ECLASS-VARIABLE: TEGRA_BCT_FLASH_CONFIG
# @DESCRIPTION:
# Flash memory configuration file to install
: ${TEGRA_BCT_FLASH_CONFIG:=}

DEPEND=""

# Check for EAPI 2 or 3
case "${EAPI:-0}" in
	3|2) ;;
	1|0|:) DEPEND="EAPI-UNSUPPORTED" ;;
esac

tegra-bct_src_configure() {
	if [ -z "${TEGRA_BCT_FILE}" ]; then
		die "No BCT file selected."
	fi

	if [ -z "${TEGRA_BCT_FLASH_CONFIG}" ]; then
		die "No flash configuration file selected."
	fi
}

tegra-bct_src_install() {
	dodir /u-boot
	insinto /u-boot

	einfo "Using ${TEGRA_BCT_FILE}"
	einfo "Using ${TEGRA_BCT_FLASH_CONFIG}"

	newins "${FILESDIR}/${TEGRA_BCT_FILE}" "board.bct"
	newins "${FILESDIR}/${TEGRA_BCT_FLASH_CONFIG}" "flash.cfg"
}

EXPORT_FUNCTIONS src_configure src_install
