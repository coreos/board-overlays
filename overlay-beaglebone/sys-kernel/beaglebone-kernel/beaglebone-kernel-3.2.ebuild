# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
EGIT_PROJECT="Hexxeh/beaglebone-kernel"
EGIT_REPO_URI="git://github.com/${EGIT_PROJECT}.git"
EGIT_BRANCH="v3.2"

# To move up to a new commit, you should update this and then bump the
# symlink to a new rev.
EGIT_COMMIT="db86a3b73e731bf679eb6a794a2a6a44e355c7e5"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git cros-kernel2

DESCRIPTION="Chrome OS Kernel-beaglebone"
KEYWORDS="arm"

DEPEND="!sys-kernel/chromeos-kernel-next
        !sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_install() {
        dodir /lib/firmware
        cros-kernel2_src_install
}
