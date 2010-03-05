# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="Das U-Boot boot loader"
HOMEPAGE="http://www.denx.de/wiki/U-Boot"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"
IUSE="600mhz fastboot"

DEPEND="chromeos-base/kernel"
RDEPEND="${DEPEND}"

u_boot=${CHROMEOS_U_BOOT:-"u-boot/files"}
config=${CHROMEOS_U_BOOT_CONFIG:-"omap3_beagle_config"}
files="${CHROMEOS_ROOT}/src/third_party/${u_boot}"

src_unpack() {
	elog "Using U-Boot files: ${files}"

	mkdir -p "${S}"
	cp -a "${files}"/* "${S}" || die "U-Boot copy failed"
}

src_prepare() {
        if use fastboot ; then
		epatch "${FILESDIR}/${P}-fastboot.patch"
        fi
	if use 600mhz ; then
		epatch "${FILESDIR}/${P}-600mhz.patch"
	fi
	epatch "${FILESDIR}/${P}-i2c2.patch"
}


src_configure() {
	elog "Using U-Boot config: ${config}"

	emake \
		ARCH=$(tc-arch-kernel) \
		CROSS_COMPILE="${CHOST}-" \
		USE_PRIVATE_LIBGCC=yes \
		${config} || die "U-Boot configuration failed"
}

src_compile() {
	emake \
		ARCH=$(tc-arch-kernel) \
		CROSS_COMPILE="${CHOST}-" \
		USE_PRIVATE_LIBGCC=yes \
		all || die "U-Boot compile failed"
}

src_install() {
	dodir /boot
	cp -a "${S}"/u-boot.bin "${D}"/boot/ || die
	"${S}"/tools/mkimage \
				-A "${ARCH}" \
				-O linux \
				-T kernel \
				-C none \
				-a 0x80008000 \
				-e 0x80008000 \
				-n 'Chrome OS BeagleBoard Kernel' \
				-d "${ROOT}"/boot/vmlinuz \
				"${D}"/boot/vmlinux.uimg || die
	ln -sf "vmlinux.uimg" "${D}"/boot/uImage || die
}
