# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="OpenMAX binary codecs"
SLOT="0"
KEYWORDS="arm"
LICENSE="NVIDIA-codecs"

RDEPEND=""
DEPEND="${RDEPEND}"

URI_BASE=${BCS_URI_BASE:="http://developer.download.nvidia.com/assets/tools/files"}
CROS_BINARY_URI="$URI_BASE/l4t/ventana_Tegra-Linux-codecs-R12.beta.1.0.tbz2"
CROS_BINARY_SUM="4f958b45e21318e568f07d8d042f5c99e19b4062"

src_install() {
	local target="${CROS_BINARY_STORE_DIR}/${CROS_BINARY_URI##*/}"
	tar xpjf "${target}" -C "${T}" || die "Failed to unpack ${target}"
	tar xpjf "${T}/restricted_codecs.tbz2" -C "${T}" || die "Failed to unpack restricted_codecs"

	insinto /lib/firmware
	local fw_files="\
	      nvmm_aacdec.axf \
	      nvmm_adtsdec.axf \
	      nvmm_h264dec2x.axf \
	      nvmm_h264dec.axf \
	      nvmm_jpegdec.axf \
	      nvmm_jpegenc.axf \
	      nvmm_manager.axf \
	      nvmm_mp3dec.axf \
	      nvmm_mpeg4dec.axf \
	      nvmm_reference.axf \
	      nvmm_service.axf \
	      nvmm_wavdec.axf \
	      "
	for i in ${fw_files}; do
	    doins ${T}/lib/firmware/${i}			|| die
	    fperms 0644 /lib/firmware/${i}			|| die
	done
}
