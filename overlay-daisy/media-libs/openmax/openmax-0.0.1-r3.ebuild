# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="Binary OpenMax libraries for ironhide"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="!chromeos-base/exynos-omx
	${DEPEND}"

URI_BASE="ssh://bcs-ironhide-private@git.chromium.org:6222/overlay-ironhide-private"
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${PF}.tbz2"
CROS_BINARY_SUM="bdc43401656937af418aee764b099eb71ff4fbed"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# openmax/usr/bin/utc_secomx
# openmax/usr/lib/libOMX.SEC.M4V.Encoder.so
# openmax/usr/lib/libOMX.SEC.M4V.Decoder.so
# openmax/usr/lib/libOMX.SEC.AVC.Decoder.so
# openmax/usr/lib/libOMX.SEC.VP8.Decoder.so
# openmax/usr/lib/libOMX.SEC.AVC.Encoder.so
# openmax/usr/lib/libOMX.SEC.WMV.Decoder.so
# openmax/usr/lib/secomx/secomxregistry
# openmax/usr/lib/libSEC_OMX_Core.so
# openmax/usr/lib/libSEC_OMX_Venc.so
# openmax/usr/lib/libsecmfcapi.so
# openmax/usr/lib/libSEC_OMX_Vdec.so
# openmax/usr/lib/libSEC_Resourcemanager.so
