# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2
CROS_WORKON_COMMIT="2cb5ad9807f941c59bdd4c3b102ed71ec1d521ea"

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