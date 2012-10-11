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

install_raspberrypi_bootloader() {
  local efi_offset_sectors=$(partoffset "$1" 12)
  local efi_size_sectors=$(partsize "$1" 12)
  local efi_offset=$(( efi_offset_sectors * 512 ))
  local efi_size=$(( efi_size_sectors * 512 ))
  local efi_dir=$(mktemp -d)

  local git_url="https://github.com/raspberrypi/firmware/raw/master"

  sudo mount -o loop,offset=${efi_offset},sizelimit=${efi_size} "$1" \
    "${efi_dir}"

  info "Downloading/installing firmware"
  sudo wget "${git_url}/boot/arm240_start.elf" -O "${efi_dir}/start.elf"
  sudo wget "${git_url}/boot/bootcode.bin" -O "${efi_dir}/bootcode.bin"

  info "Creating boot configuration files"
  sudo cp "${ROOT}/boot/cmdline.txt" "${efi_dir}/"
  sudo cp "${ROOT}/boot/config.txt" "${efi_dir}/"

  sudo umount "${efi_dir}"
  rmdir "${efi_dir}"
}

board_setup() {
  install_raspberrypi_bootloader "$1"
  install_hybrid_mbr "$1"
}
