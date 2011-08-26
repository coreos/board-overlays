# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2
CROS_WORKON_COMMIT="5cb504bb2aa840234d61390ef66c0e7362e7b744"

inherit cros-fdt

CROS_WORKON_PROJECT="chromiumos/third_party/u-boot"
CROS_WORKON_LOCALNAME="u-boot"
CROS_WORKON_SUBDIR="files"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit cros-workon

DESCRIPTION="Tegra2 seaboard variant FDT files"
LICENSE=""
SLOT="0"
KEYWORDS="arm"
IUSE=""

# Build all seaboard files
CROS_FDT_ROOT="board/nvidia/seaboard"
CROS_FDT_SOURCES="*"

# Depend on the old name of this package being uninstalled.
# TODO(dianders): Remove if >1 month has passed (after 8/15/2011)
DEPEND="!sys-boot/tegra2-fdt"