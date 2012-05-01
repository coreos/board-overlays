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

CROS_BINARY_URI="http://developer.download.nvidia.com/assets/tools/files/l4t/r15_beta/cardhu_Tegra-Linux-codecs-R15.beta.1.0_armel.tar.gz"
CROS_BINARY_SUM="3a512bab05f5ac031a9a35c62ca9a0fd0b3d1c82"

src_install() {
	local target="${CROS_BINARY_STORE_DIR}/${CROS_BINARY_URI##*/}"
	local flags

	case "${target##*.}" in
		gz|tgz) flags="z";;
		bz2|tbz2) flags="j";;
		*) die "Unsupported binary file format ${target##*.}"
	esac

	tar "${flags}xpf" "${target}" -C "${T}" || die "Failed to unpack ${target}"
	tar "jxpf" "${T}/restricted_codecs.tbz2" -C "${T}" || die "Failed to unpack restricted_codecs"

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
	      nvmm_service.axf \
	      nvmm_wavdec.axf \
	      "
	for i in ${fw_files}; do
	    doins ${T}/lib/firmware/${i}			|| die
	    fperms 0644 /lib/firmware/${i}			|| die
	done
}
