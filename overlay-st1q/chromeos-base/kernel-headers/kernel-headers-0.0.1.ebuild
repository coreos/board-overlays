# Copyright (c) 2009 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

EGIT_REPO_URI="git://codeaurora.org/quic/chrome/kernel.git"
if [ "${CHROMEOS_KERNEL}" = "kernel-qualcomm" ]; then
	# Current HEAD of kernel.git qualcomm-2.6.35 branch.
	EGIT_COMMIT="579a8cea41021d78a77fba6f83d29e5d57d371ab"
	EGIT_BRANCH="cros/qualcomm-2.6.35"
else
	# Current HEAD of kernel.git master branch.
	EGIT_COMMIT="d4e4d17a56d83874d66b4ca3efeaaa4c0d97c338"
fi

if [[ -n "${PRIVATE_REPO}" ]] ; then
	EGIT_REPO_URI="${PRIVATE_REPO}/kernel/msm"
	EGIT_BRANCH="android-msm-2.6.35"
fi

inherit git

DESCRIPTION="Chrome OS Kernel Headers"
HOMEPAGE="http://src.chromium.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 arm"
IUSE=""

src_unpack() {
	# path points to CROS_WORKON_LOCALNAME for chromeos-kernel-st1q
	if [[ -n "${PRIVATE_REPO}" ]] ; then
		path="${CROS_WORKON_SRCROOT}/src/third_party/qcom/opensource/kernel/8660"
	else
		path="${CROS_WORKON_SRCROOT}/src/third_party/kernel-qualcomm"
	fi

	if [ -d "${path}/.git" ]; then
		git clone -sn "${path}" "${S}" || die "Can't clone ${path}."
		if ! ( cd "${S}" && git checkout ${EGIT_COMMIT} ) ; then
			ewarn "Cannot run git checkout ${EGIT_COMMIT} in ${S}."
			ewarn "Is ${path} up to date? Try running repo sync."
			die "Cannot run git checkout ${EGIT_COMMIT} in ${S}."
		fi
	else
		git_src_unpack
	fi
}

src_compile() {
	elog " Nothing to compile"
}

src_install() {
	emake \
	  ARCH=$(tc-arch-kernel) \
	  CROSS_COMPILE="${CHOST}-" \
	  INSTALL_HDR_PATH="${D}"/usr \
	  headers_install || die

	#
	# These subdirectories are installed by various ebuilds and we don't
	# want to conflict with them.
	#
	rm -rf "${D}"/usr/include/sound
	rm -rf "${D}"/usr/include/scsi
	rm -rf "${D}"/usr/include/drm

	#
	# Double hack, install the Qualcomm drm header anyway, its not included in
	# libdrm, and is required to build xf86-video-msm.
	#
	if [ "${CHROMEOS_KERNEL}" = "kernel-qualcomm" ]; then
		if [ -r "${S}"/include/drm/kgsl_drm.h ]; then
			insinto /usr/include/drm
			doins "${S}"/include/drm/kgsl_drm.h
		fi
	fi
}
