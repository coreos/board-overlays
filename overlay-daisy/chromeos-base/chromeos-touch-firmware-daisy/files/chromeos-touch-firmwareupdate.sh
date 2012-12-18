#!/bin/sh

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

. /usr/share/misc/shflags

DEFINE_boolean 'force' ${FLAGS_FALSE} "Force update" 'f'
DEFINE_boolean 'recovery' ${FLAGS_FALSE} "Recovery. Allows for rollback" 'r'
DEFINE_string 'device' '' "device name" 'd'
DEFINE_string 'firmware_name' '' "firmware name (in /lib/firmware)" 'n'

log_msg() {
  logger -t "chromeos-touch-firmwareupdate[${PPID}]" "$@"
  echo "$@"
}

die() {
  log_msg "error: $*"
  exit 1
}

# Parse command line
FLAGS "$@" || exit 1
eval set -- "${FLAGS_ARGV}"

if [ -z "${FLAGS_device}" ]; then
  die "Please specify a device using -d"
fi

trackpad_device_name="${FLAGS_device}"
i2c_devices_path="/sys/bus/i2c/devices"
trackpad_path=""
update_needed=${FLAGS_FALSE}

# Find trackpad path in i2c devices.
for dev in "${i2c_devices_path}"/*/name; do
  dev_name=$(cat "${dev}")
  if [ "${trackpad_device_name}" = "${dev_name}" ]; then
    trackpad_path="${dev%/name}"
    break
  fi
done
if [ -z "${trackpad_path}" ]; then
  die "${trackpad_device_name} not found on system. Aborting update."
fi

fw_link_name=${FLAGS_firmware_name:-${trackpad_device_name}.bin}
case ${fw_link_name} in
/*) fw_link_path=${fw_link_name} ;;
*)  fw_link_path="/lib/firmware/${fw_link_name}" ;;
esac

update_firmware() {
  printf 1 > "$1/update_fw"
  local ret=$?
  if [ ${ret} -ne 0 ]; then
    die "Error updating touch firmware. ${ret}"
  fi
}

get_active_firmware_version() {
  active_fw_version=$(cat "$1/firmware_version")
  active_fw_version_major=${active_fw_version%.*}
  active_fw_version_minor=${active_fw_version#*.}
}

fw_path=$(readlink "${fw_link_path}")
if [ ! -e "${fw_link_path}" ]; then
  die "No valid firmware for ${trackpad_device_name} found."
fi
fw_filename=${fw_path##*/}
fw_name=${fw_filename%.bin}
product_id=${fw_name%_*}

fw_version=${fw_name#"${product_id}_"}
fw_version_major=${fw_version%.*}
fw_version_minor=${fw_version#*.}
active_product_id=$(cat "${trackpad_path}/product_id")

if [ -z "${active_product_id}" ]; then
  log_msg "Trackpad in non operational state. Updating."
  update_needed=${FLAGS_TRUE}
fi

if [ -n "${active_product_id}" ] &&
   [ "${product_id}" != "${active_product_id}" ]; then
  log_msg "Hardware product id : ${active_product_id}"
  log_msg "Updater product id  : ${product_id}"
  die "Touch firmware updater: Product ID mismatch!"
fi

get_active_firmware_version "${trackpad_path}"

log_msg "Product ID : ${product_id}"
log_msg "Current Firmware: ${active_fw_version}"
log_msg "Updater Firmware: ${fw_version}"

if [ ${active_fw_version_major} -lt ${fw_version_major} ] ||
     ([ ${active_fw_version_major} -eq ${fw_version_major} ] &&
      [ ${active_fw_version_minor} -lt ${fw_version_minor} ]); then
  log_msg "Update needed."
  update_needed=${FLAGS_TRUE}
elif [ ${active_fw_version_major} -eq ${fw_version_major} ] &&
     [ ${active_fw_version_minor} -eq ${fw_version_minor} ]; then
  log_msg "Firmware up to date."
elif [ ${FLAGS_recovery} -eq ${FLAGS_TRUE} ]; then
  log_msg "Recovery firmware update. Rolling back to ${fw_version}."
  update_needed=${FLAGS_TRUE}
else
  log_msg "Current firmware ahead of updater. Use --recovery to downgrade."
fi

if [ ${FLAGS_force} -eq ${FLAGS_TRUE} ]; then
  log_msg "Forcing update."
fi

if [ ${FLAGS_force} -eq ${FLAGS_TRUE} ] ||
   [ ${update_needed} -eq  ${FLAGS_TRUE} ]; then
  log_msg "Update FW to ${fw_name}"
  update_firmware "${trackpad_path}"
  get_active_firmware_version "${trackpad_path}"
  if [ ${active_fw_version_major} -ne ${fw_version_major} ] ||
     [ ${active_fw_version_minor} -ne ${fw_version_minor} ]; then
    die "Firmware update failed."
  fi
  log_msg "Update FW succeded. Current Firmware: ${active_fw_version}"
fi

exit 0
