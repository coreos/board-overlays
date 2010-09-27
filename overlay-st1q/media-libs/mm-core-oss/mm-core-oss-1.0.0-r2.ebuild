# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

if [ "${CHROMEOS_KERNEL_SPLITCONFIG}" = "chromeos-qsd8660-st1_5" ]; then
	CROS_WORKON_COMMIT="6a58c5f5b923acd2b45552770e9efbcbe0101c83"
else
	CROS_WORKON_COMMIT="faaacfe0d98e4b3c01b16803388e3f57160ecfdf"
fi

if [[ -n "${PRIVATE_REPO}" ]] ; then
	CROS_WORKON_REPO="${PRIVATE_REPO}"
	CROS_WORKON_PROJECT="platform/vendor/qcom-opensource/omx/mm-core"
	CROS_WORKON_LOCALNAME="qcom/opensource/omx/mm-core"

	# EGIT_BRANCH must be set prior to 'inherit git' being used by cros-workon
	EGIT_BRANCH=chromiumos
else
	CROS_WORKON_PROJECT="mm-core.git"
fi

inherit cros-workon toolchain-funcs

DESCRIPTION="omx multi-media core libraries"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND=""
DEPEND="chromeos-base/kernel"

src_compile() {
	tc-export CC CXX
	emake CCC="${CXX}" LIBVER=${PV} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" LIBVER=${PV} install || die "emake install failed"
}
