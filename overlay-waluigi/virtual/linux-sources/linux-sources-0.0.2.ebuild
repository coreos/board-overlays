# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Chrome OS Kernel virtual package"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="-kernel_next -kernel_sources"

# By default, we point to the remote nVidia kernel (by using the waluig-kernel
# ebuild).  A suggestion is that if you want to locally work on the kernel, you
# should:
# - Add nVidia kernel as a remote to kernel-next:
#     cd ~/trunk/src/third_party/kernel-next/
#     git remote add nvidia git://nv-tegra.nvidia.com/user/amartin/linux-2.6.git
#     git fetch nvidia
#     git checkout nvidia/chromeos-3.0
#     git checkout -b mywork
# - Start working on kernel-next:
#     cros_workon --board=waluigi start chromeos-kernel-next
# - Switch to the kernel-next profile:
#     cros_choose_profile --board=waluigi --profile=kernel-next
#
# You can switch back with: cros_choose_profile --board=waluigi --profile=base

RDEPEND="
	sys-kernel/waluigi-kernel[kernel_sources=]
"
