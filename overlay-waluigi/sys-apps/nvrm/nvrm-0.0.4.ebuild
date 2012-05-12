# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
IUSE="hardfp"
LICENSE="NVIDIA"

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	if use hardfp; then
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/mobile/files/l4t/cardhu_nv-tegra_base_R15-Beta.1.0_armhf.tbz2"
		CROS_BINARY_SUM="2eff40815c47febb61ae6f5a5561b36c4823f4a1"
	else
		CROS_BINARY_URI="http://developer.download.nvidia.com/assets/tools/files/l4t/r15_beta/cardhu_Tegra-Linux-R15.beta.1.0_armel.tbz2"
		CROS_BINARY_SUM="bf5f5fab362ee5fdf89f11b11a8883cdb0b6ccd8"
	fi
	cros-binary_src_unpack
}

src_install() {
	local target="${CROS_BINARY_STORE_DIR}/${CROS_BINARY_URI##*/}"
	tar xpjf "${target}" -C "${T}" || die "Failed to unpack ${target}"
	if use hardfp; then
		tar xpzf "${T}/base.tgz" -C "${T}" || die "Failed to unpack base"
	else
		tar xpzf "${T}/Linux_for_Tegra/nv_tegra/base.tgz" -C "${T}" || die "Failed to unpack base"
	fi

	insinto /lib/firmware
	doins ${T}/lib/firmware/nvavp_os_00001000.bin		|| die
	fperms 0644 /lib/firmware/nvavp_os_00001000.bin		|| die
	doins ${T}/lib/firmware/nvavp_os_0ff00000.bin		|| die
	fperms 0644 /lib/firmware/nvavp_os_0ff00000.bin		|| die
	doins ${T}/lib/firmware/nvavp_os_e0000000.bin		|| die
	fperms 0644 /lib/firmware/nvavp_os_e0000000.bin		|| die
	doins ${T}/lib/firmware/nvavp_os_eff00000.bin		|| die
	fperms 0644 /lib/firmware/nvavp_os_eff00000.bin		|| die
	doins ${T}/lib/firmware/nvavp_vid_ucode_alt.bin		|| die
	fperms 0644 /lib/firmware/nvavp_vid_ucode_alt.bin	|| die
	doins ${T}/lib/firmware/nvrm_avp_0ff00000.bin		|| die
	fperms 0644 /lib/firmware/nvrm_avp_0ff00000.bin		|| die
	doins ${T}/lib/firmware/nvrm_avp_8e000000.bin		|| die
	fperms 0644 /lib/firmware/nvrm_avp_8e000000.bin		|| die
	doins ${T}/lib/firmware/nvrm_avp_9e000000.bin		|| die
	fperms 0644 /lib/firmware/nvrm_avp_9e000000.bin		|| die
	doins ${T}/lib/firmware/nvrm_avp_be000000.bin		|| die
	fperms 0644 /lib/firmware/nvrm_avp_be000000.bin		|| die
	doins ${T}/lib/firmware/nvrm_avp_eff00000.bin		|| die
	fperms 0644 /lib/firmware/nvrm_avp_eff00000.bin		|| die

	dolib.so ${T}/usr/lib/libcgdrv.so			|| die
	dolib.so ${T}/usr/lib/libnvapputil.so			|| die
	dolib.so ${T}/usr/lib/libnvcwm.so			|| die
	dolib.so ${T}/usr/lib/libnvdc.so			|| die
	dolib.so ${T}/usr/lib/libnvddk_2d.so			|| die
	dolib.so ${T}/usr/lib/libnvddk_2d_v2.so			|| die
	dolib.so ${T}/usr/lib/libnvddk_disp.so			|| die
	dolib.so ${T}/usr/lib/libnvddk_mipihsi.so		|| die
	dolib.so ${T}/usr/lib/libnvdioconverter.so		|| die
	dolib.so ${T}/usr/lib/libnvdispatch_helper.so		|| die
	dolib.so ${T}/usr/lib/libnvdispmgr_d.so			|| die
	dolib.so ${T}/usr/lib/libnvdispmgr_impl_d.so		|| die
	dolib.so ${T}/usr/lib/libnvflash.so			|| die
	dolib.so ${T}/usr/lib/libnvavp.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_audio.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_camera.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_contentpipe.so		|| die
	dolib.so ${T}/usr/lib/libnvmm_image.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_manager.so		|| die
	dolib.so ${T}/usr/lib/libnvmm_parser.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_service.so		|| die
	dolib.so ${T}/usr/lib/libnvmm.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_utils.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_video.so			|| die
	dolib.so ${T}/usr/lib/libnvmm_writer.so			|| die
	dolib.so ${T}/usr/lib/libnvmmlite.so			|| die
	dolib.so ${T}/usr/lib/libnvmmlite_audio.so		|| die
	dolib.so ${T}/usr/lib/libnvmmlite_image.so		|| die
	dolib.so ${T}/usr/lib/libnvmmlite_utils.so		|| die
	dolib.so ${T}/usr/lib/libnvmmlite_video.so		|| die
	dolib.so ${T}/usr/lib/libnvos.so			|| die
	dolib.so ${T}/usr/lib/libnvparser.so			|| die
	dolib.so ${T}/usr/lib/libnvrm_graphics.so		|| die
	dolib.so ${T}/usr/lib/libnvrm_graphics_impl.so		|| die
	dolib.so ${T}/usr/lib/libnvrm.so			|| die
	dolib.so ${T}/usr/lib/libnvrm_impl.so			|| die
	dolib.so ${T}/usr/lib/libnvsm.so			|| die
	dolib.so ${T}/usr/lib/libnvtestio.so			|| die
	dolib.so ${T}/usr/lib/libnvtestresults.so		|| die
	dolib.so ${T}/usr/lib/libnvtvmr.so			|| die
	dolib.so ${T}/usr/lib/libnvwinsys.so			|| die
	dolib.so ${T}/usr/lib/libnvwsi.so			|| die
	dolib.so ${T}/usr/lib/libnvodm_dtvtuner.so		|| die
	dolib.so ${T}/usr/lib/libnvodm_hdmi.so			|| die
	dolib.so ${T}/usr/lib/libnvodm_imager.so		|| die
	dolib.so ${T}/usr/lib/libnvodm_misc.so			|| die
	dolib.so ${T}/usr/lib/libnvodm_query.so			|| die
	dolib.so ${T}/usr/lib/libnvodm_disp.so			|| die

	insinto /etc/udev/rules.d
	doins ${FILESDIR}/etc/udev/rules.d/51-nvrm.rules        || die
}
