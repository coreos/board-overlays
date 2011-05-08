# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EAPI="2"

DESCRIPTION="Empty ebuild to override the chromeos-firmware ebuild in the
chromeos-overlay which collides with the chromeos-firmware-tegra2 ebuild."
LICENSE="Proprietary"
SLOT="0"
KEYWORDS="arm"

# TODO(dparker): Remove this ebuild after the chromeos-firmware ebuild
# is removed as a dependency from the chromeos-base/chromeos ebuild.
