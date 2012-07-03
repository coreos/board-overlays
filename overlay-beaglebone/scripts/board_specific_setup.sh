#!/bin/bash

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

board_setup() {
  local efi_offset_sectors=$(partoffset "$1" 12)
  local efi_size_sectors=$(partsize "$1" 12)
  local efi_offset=$(( efi_offset_sectors * 512 ))
  local efi_size=$(( efi_size_sectors * 512 ))
  local efi_dir=$(mktemp -d)

  sudo mount -o loop,offset=${efi_offset},sizelimit=${efi_size} "$1" "$efi_dir"

  sudo cp "/build/${BOARD}/firmware/u-boot.img" "$efi_dir/"
  sudo wget "http://git.sabayon.org/molecules.git/plain/boot/arm/beaglebone/MLO" -O "$efi_dir/MLO"

  sudo umount "$efi_dir"
  rmdir "$efi_dir"
}

skip_blacklist_check=1
skip_test_build_root=1
skip_test_image_content=1
