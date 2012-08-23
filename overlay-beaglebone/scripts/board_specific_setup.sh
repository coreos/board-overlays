#!/bin/bash

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Creates a hybrid MBR which points the MBR partition 1 to GPT
# partition 12 (ESP).
install_hybrid_mbr() {
  info "Creating hybrid MBR"
  locate_gpt
  local start_esp=$(partoffset "$1" 12)
  local num_esp_sectors=$(partsize "$1" 12)
  sudo sfdisk "$1" <<EOF
unit: sectors

disk1 : start=   ${start_esp}, size=    ${num_esp_sectors}, Id= c, bootable
disk2 : start=   1, size=    1, Id= ee
EOF
}

# Downloads and installs the MLO and copies u-boot to the ESP.
# This is used combined with a hybrid MBR to allow booting
# a Beaglebone from microSD only.
install_beaglebone_bootloader() {
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

board_setup() {
  install_beaglebone_bootloader "$1"
  install_hybrid_mbr "$1"
}

skip_blacklist_check=1
skip_test_build_root=1
skip_test_image_content=1
