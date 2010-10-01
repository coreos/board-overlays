# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

CROS_WORKON_COMMIT="b89949d6e0c41dec0bd6347d593669ce24031465"
# EGIT_BRANCH must be set prior to 'inherit git' being used by cros-workon
EGIT_BRANCH="froyo"

if [ "${CHROMEOS_KERNEL_SPLITCONFIG}" = "chromeos-qsd8650a-st1_5" ]; then
	CROS_WORKON_COMMIT="054eab1ec2d1bf52e7ee2f5b1904b9c68da92923"
	EGIT_BRANCH="master"
fi

if [[ -n "${PRIVATE_REPO}" ]] ; then
    CROS_WORKON_REPO="${PRIVATE_REPO}"
    CROS_WORKON_PROJECT="platform/vendor/qcom-opensource/omx/mm-video"
    CROS_WORKON_LOCALNAME="qcom/opensource/omx/mm-video"
else
    CROS_WORKON_PROJECT="mm-video"
fi

inherit cros-workon toolchain-funcs

DESCRIPTION="omx multi-media video libraries"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="media-libs/mm-core-oss
	virtual/opengles"
DEPEND="${RDEPEND}
	chromeos-base/kernel"


src_compile() {
	tc-export CC CXX
	emake CCC="${CXX}" LIBVER=${PV} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" LIBVER=${PV} install || die "emake install failed"
	insinto /etc/udev/rules.d
	doins "${FILESDIR}"/62-vdec.rules || die
}
