# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

#
# Original Author: The Chromium OS Authors <chromium-os-dev@chromium.org>
# Purpose: Install Tegra BCT files for firmware construction.
#

# @ECLASS-VARIABLE: TEGRA_BCT_SDRAM_CONFIG
# @DESCRIPTION:
# SDRAM memory timing configuration file to install
: ${TEGRA_BCT_SDRAM_CONFIG:=}

# @ECLASS-VARIABLE: TEGRA_BCT_FLASH_CONFIG
# @DESCRIPTION:
# Flash memory configuration file to install
: ${TEGRA_BCT_FLASH_CONFIG:=}

# Check for EAPI 2 or 3
case "${EAPI:-0}" in
	3|2) ;;
	1|0|:) DEPEND="EAPI-UNSUPPORTED" ;;
esac

tegra-bct_src_configure() {
	local sdram_file=${FILESDIR}/${TEGRA_BCT_SDRAM_CONFIG}
	local flash_file=${FILESDIR}/${TEGRA_BCT_FLASH_CONFIG}

	if [ -z "${TEGRA_BCT_SDRAM_CONFIG}" ]; then
		die "No SDRAM configuration file selected."
	fi

	if [ -z "${TEGRA_BCT_FLASH_CONFIG}" ]; then
		die "No flash configuration file selected."
	fi

	einfo "Using sdram config file: ${sdram_file}"
	einfo "Using flash config file: ${flash_file}"

	cat ${flash_file} > board.cfg ||
		die "Failed to read flash config file."

	cat ${sdram_file} >> board.cfg ||
		die "Failed to read SDRAM config file."
}

tegra-bct_src_compile() {
	cbootimage -gbct board.cfg board.bct || die "Failed to generate BCT."
}

tegra-bct_src_install() {
	local sdram_file=${FILESDIR}/${TEGRA_BCT_SDRAM_CONFIG}
	local flash_file=${FILESDIR}/${TEGRA_BCT_FLASH_CONFIG}

	insinto /firmware/bct

	doins "${sdram_file}"
	doins "${flash_file}"

	if [ "$(basename ${sdram_file})" != "sdram.cfg" ]; then
		dosym "$(basename ${sdram_file})" /firmware/bct/sdram.cfg
	fi

	if [ "$(basename ${flash_file})" != "flash.cfg" ]; then
		dosym "$(basename ${flash_file})" /firmware/bct/flash.cfg
	fi

	doins board.cfg
	doins board.bct

	# -----------------------------------------------------------------
	# This section will be deleted once all scripts and ebuilds
	# switched over to using /firmware instead of /u-boot
	# -----------------------------------------------------------------
	insinto /u-boot/bct

	doins "${sdram_file}"
	doins "${flash_file}"

	if [ "$(basename ${sdram_file})" != "sdram.cfg" ]; then
		dosym "$(basename ${sdram_file})" /u-boot/bct/sdram.cfg
	fi

	if [ "$(basename ${flash_file})" != "flash.cfg" ]; then
		dosym "$(basename ${flash_file})" /u-boot/bct/flash.cfg
	fi

	doins board.cfg
	doins board.bct
	# -----------------------------------------------------------------
}

EXPORT_FUNCTIONS src_configure src_compile src_install
