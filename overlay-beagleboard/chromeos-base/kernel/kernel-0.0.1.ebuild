# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit eutils git toolchain-funcs

DESCRIPTION="Chrome OS Kernel"
EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git"
EGIT_TREE="58cf2f1425abfd3a449f9fe985e48be2d2555022"
HOMEPAGE="http://src.chromium.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND=""

kernel=${CHROMEOS_KERNEL:-"kernel/files"}
files="${CHROMEOS_ROOT}/src/third_party/${kernel}"
config="beagleboard_defconfig"

src_prepare() {
	elog "Applying BeagleBoard kernel patches"
	QUILT_PATCHES="${FILESDIR}/${P}" quilt push -a
}

src_configure() {
	elog "Configuring BeagleBoard kernel"
	emake ARCH="${ARCH}" CROSS_COMPILE="${CHOST}-" distclean
	cp "${FILESDIR}/${P}/${config}" ".config"
}

src_compile() {
	elog "Compiling BeagleBoard kernel"
	emake ARCH="${ARCH}" CROSS_COMPILE="${CHOST}-"
}

src_install() {
	elog "Installing BeagleBoard kernel"
	dodir boot
	emake \
		ARCH=$(tc-arch-kernel) \
		CROSS_COMPILE="${CHOST}-" \
		INSTALL_PATH="${D}/boot" \
		install || die

	emake \
		ARCH=$(tc-arch-kernel) \
		CROSS_COMPILE="${CHOST}-" \
		INSTALL_MOD_PATH="${D}" \
		modules_install || die

	emake \
		ARCH=$(tc-arch-kernel) \
		CROSS_COMPILE="${CHOST}-" \
		INSTALL_MOD_PATH="${D}" \
		firmware_install || die

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
}
