# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
LICENSE="NVIDIA"

RDEPEND=""
DEPEND="${RDEPEND}"

CROS_BINARY_URI="http://developer.download.nvidia.com/assets/tools/files/l4t/r15_beta/ventana_Tegra-Linux-R15.beta.1.0_armel.tbz2"
CROS_BINARY_SUM="93a2024b554b13cbf12218301c7652091de0aea3"

src_install() {
	local target="${CROS_BINARY_STORE_DIR}/${CROS_BINARY_URI##*/}"
	tar xpjf "${target}" -C "${T}" || die "Failed to unpack ${target}"
	tar xpzf "${T}/Linux_for_Tegra/nv_tegra/base.tgz" -C "${T}" || die "Failed to unpack base"

	insinto /lib/firmware
	doins ${T}/lib/firmware/nvrm_avp.bin			|| die
	fperms 0644 /lib/firmware/nvrm_avp.bin			|| die

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
