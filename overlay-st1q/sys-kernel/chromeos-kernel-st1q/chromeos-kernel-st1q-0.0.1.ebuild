# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Chrome OS Kernel"
HOMEPAGE="http://src.chromium.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 arm"
IUSE="-compat_wireless"
PROVIDE="virtual/kernel"

DEPEND="sys-apps/debianutils"
RDEPEND="chromeos-base/kernel-headers"

vmlinux_text_base=${CHROMEOS_U_BOOT_VMLINUX_TEXT_BASE:-0x20008000}

# Use a single or split kernel config as specified in the board or variant
# make.conf overlay

config=${CHROMEOS_KERNEL_SPLITCONFIG:-"chromeos-qsd8660-st1_5"}

CROS_WORKON_LOCALNAME="../third_party/kernel-qualcomm"
CROS_WORKON_PROJECT="kernel"
if [ "${CHROMEOS_KERNEL_SPLITCONFIG}" = "chromeos-st1q-qrdc" ]; then
	CROS_WORKON_COMMIT="47a883f527282bc7666c7f5bed90aab786396e7a"
	EGIT_BRANCH="qualcomm-2.6.35"
elif [ "${CHROMEOS_KERNEL_SPLITCONFIG}" = "chromeos-qsd8660-st1_5" ]; then
	CROS_WORKON_COMMIT="47a883f527282bc7666c7f5bed90aab786396e7a"
	EGIT_BRANCH="qualcomm-2.6.35"
elif [ "${CHROMEOS_KERNEL_SPLITCONFIG}" = "chromeos-qsd8650a-st1_5" ]; then
	CROS_WORKON_COMMIT="2e15509fd572442f213f44743a45f3413368cf3e"
	EGIT_BRANCH="qualcomm-2.6.32.9"
fi

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit cros-workon

# Allow override of kernel arch.
kernel_arch=${CHROMEOS_KERNEL_ARCH:-"$(tc-arch-kernel)"}

cross=${CHOST}-
# Hack for using 64-bit kernel with 32-bit user-space
if [ "${ARCH}" = "x86" -a "${kernel_arch}" = "x86_64" ]; then
	cross=${CBUILD}-
fi

src_configure() {
	elog "Using kernel config: ${config}"

	if [ -n "${CHROMEOS_KERNEL_CONFIG}" ]; then
		cp -f "${config}" "${S}"/.config || die
	else
		chromeos/scripts/prepareconfig ${config} || die
	fi

	# Use default for any options not explitly set in splitconfig
	yes "" | emake ARCH=${kernel_arch} oldconfig || die

	if use compat_wireless; then
		"${S}"/chromeos/scripts/compat_wireless_config "${S}"
	fi
}

src_compile() {
	emake \
		ARCH=${kernel_arch} \
		CROSS_COMPILE="${cross}" || die

	if use compat_wireless; then
		# compat-wireless support must be done after
		emake M=chromeos/compat-wireless \
			ARCH=${kernel_arch} \
			CROSS_COMPILE="${cross}" || die
	fi
}

src_install() {
	dodir boot

	emake \
		ARCH=${kernel_arch}\
		CROSS_COMPILE="${cross}" \
		INSTALL_PATH="${D}/boot" \
		install || die

	emake \
		ARCH=${kernel_arch}\
		CROSS_COMPILE="${cross}" \
		INSTALL_MOD_PATH="${D}" \
		modules_install || die

	if use compat_wireless; then
		# compat-wireless modules are built+installed separately
		# NB: the updates dir is handled specially by depmod
		emake M=chromeos/compat-wireless \
			ARCH=${kernel_arch}\
			CROSS_COMPILE="${cross}" \
			INSTALL_MOD_DIR=updates \
			INSTALL_MOD_PATH="${D}" \
			modules_install || die
	fi

	emake \
		ARCH=${kernel_arch}\
		CROSS_COMPILE="${cross}" \
		INSTALL_MOD_PATH="${D}" \
		firmware_install || die

	if [ "${ARCH}" = "arm" ]; then
		version=$(ls "${D}"/lib/modules)

		cp -a \
			"${S}"/arch/"${ARCH}"/boot/zImage \
			"${D}/boot/vmlinuz-${version}" || die

		cp -a \
			"${S}"/System.map \
			"${D}/boot/System.map-${version}" || die

		cp -a \
			"${S}"/.config \
			"${D}/boot/config-${version}" || die

		ln -sf "vmlinuz-${version}"    "${D}"/boot/vmlinuz    || die
		ln -sf "System.map-${version}" "${D}"/boot/System.map || die
		ln -sf "config-${version}"     "${D}"/boot/config     || die

		dodir /boot

		/usr/bin/mkimage -A "${ARCH}" \
							-O linux \
							-T kernel \
							-C none \
							-a ${vmlinux_text_base} \
							-e ${vmlinux_text_base} \
							-n kernel \
							-d "${D}"/boot/vmlinuz \
							"${D}"/boot/vmlinux.uimg || die
	fi
}
