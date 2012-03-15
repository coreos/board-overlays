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
CROS_BINARY_SUM="09f885a6f4a49b3a74917121c130c9650e2282bf"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

# The tbz2 file contains the following:
# SECOMX_Files/usr/bin/utc_secomx
# SECOMX_Files/usr/lib/libOMX.SEC.M4V.Encoder.so
# SECOMX_Files/usr/lib/libOMX.SEC.M4V.Decoder.so
# SECOMX_Files/usr/lib/libOMX.SEC.AVC.Decoder.so
# SECOMX_Files/usr/lib/libOMX.SEC.VP8.Decoder.so
# SECOMX_Files/usr/lib/libOMX.SEC.AVC.Encoder.so
# SECOMX_Files/usr/lib/libOMX.SEC.WMV.Decoder.so
# SECOMX_Files/usr/lib/secomx/secomxregistry
# SECOMX_Files/usr/lib/libSEC_OMX_Core.so
# SECOMX_Files/usr/lib/libSEC_OMX_Venc.so
# SECOMX_Files/usr/lib/libsecmfcapi.so
# SECOMX_Files/usr/lib/libSEC_OMX_Vdec.so
# SECOMX_Files/usr/lib/libSEC_Resourcemanager.so
