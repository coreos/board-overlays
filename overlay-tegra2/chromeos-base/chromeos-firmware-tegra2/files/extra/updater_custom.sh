# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

TARGET_PLATFORM="U-Boot"

CUSTOMIZATION_RW_COMPATIBLE_CHECK="updater_custom_rw_compatible_check"

updater_custom_main() {
  debug_msg "Customization for $TARGET_PLATFORM loaded."
}

updater_custom_rw_compatible_check() {
  # Returns $FLAGS_FALSE if not compatible (i.e., need incompatible_mode)

  if [ "${FLAGS_update_main}" = ${FLAGS_TRUE} ]; then
    case "$FWID" in
      * )
        # For ARM platforms, there is almost nothing to change in RW yet;
        # let's convert every 'autoupdate' request into 'recovery.
        # We need to fix this one the new design of ARM firmware updating is
        # complete.
        VERSION=$(echo $(cat VERSION | grep BIOS\ version | cut -f2 -d:))
        if [ "$VERSION" != "$FWID" ]; then
          return $FLAGS_FALSE
        else
          true
        fi
    esac
  fi
}

# One-time shot update for legacy firmware
if ! crossystem hwid >/dev/null 2>&1; then
  verbose_msg "One-time update from legacy firmware."
  FLAGS_mode=factory_install
fi
