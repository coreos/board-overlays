# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

CUSTOMIZATION_RW_COMPATIBLE_CHECK="updater_custom_rw_compatible_check"

updater_custom_main() {
  true
}

updater_custom_rw_compatible_check() {
  # Returns $FLAGS_FALSE if not compatible (i.e., need incompatible_mode)

  if [ "${FLAGS_update_main}" = ${FLAGS_TRUE} ]; then
    case "$FWID" in
      * )
        true
    esac
  fi
}
