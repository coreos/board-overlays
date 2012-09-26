#!/bin/sh

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

. /usr/share/misc/shflags

DEFINE_boolean 'force' $FLAGS_FALSE "Force update" 'f'
DEFINE_boolean 'recovery' $FLAGS_FALSE "Recovery. Allows for rollback" 'r'
DEFINE_string 'device' '' "device name" 'd'
DEFINE_string 'firmware_name' '' "firmware name (in /lib/firmware)" 'n'

log_msg() {
    logger -t "chromeos-touch-firmwareupdate[${PPID}]" "$@"
    echo "$@"
}

# Parse command line
FLAGS "$@" || exit 1
eval set -- "$FLAGS_ARGV"

if [ -z "$FLAGS_device" ]; then
    log_msg "Please specify a device using -d"
    return 1
fi

trackpad_device_name="$FLAGS_device"
i2c_devices_path="/sys/bus/i2c/devices"
trackpad_path=""
update_needed=0

#find trackpad path in i2c devices
for dev in $(ls $i2c_devices_path); do
    dev_name=$(cat $i2c_devices_path/$dev/name)
    if [ -n "$dev_name" ] &&
       [ "$trackpad_device_name" = "$dev_name" ]; then
        trackpad_path="$i2c_devices_path/$dev"
        break
    fi
done
if [ -z "$trackpad_path" ]; then
    log_msg "$trackpad_device_name not found on system. Aborting update."
    return 1
fi

if [ -z "$FLAGS_firmware_name" ]; then
    fw_link_name="$trackpad_device_name.bin"
else
    fw_link_name="$FLAGS_firmware_name"
fi
fw_link_path="/lib/firmware/$fw_link_name"

update_firmware() {
    echo -n 1 > $trackpad_path/update_fw
}

get_active_firmware_version() {
    active_fw_version=$(cat $trackpad_path/firmware_version)
    active_fw_version_major=${active_fw_version%%.*}
    active_fw_version_minor=${active_fw_version##*.}
}

fw_path=$(readlink "$fw_link_path")
if [ ! -e "$fw_link_path" ] ||
   [ ! -e "$fw_path" ]; then
    log_msg "No valid firmware for $trackpad_device_name found."
    return 1
fi
fw_filename=$(basename $fw_path)
fw_name=${fw_filename%%.bin}
product_id=${fw_name%%_*}

fw_version=${fw_name##"${product_id}_"}
fw_version_major=${fw_version%%.*}
fw_version_minor=${fw_version##*.}
active_product_id=$(cat $trackpad_path/product_id)

if [ -z "$active_product_id" ]; then
    log_msg "Trackpad in non operational state. Updating."
    update_needed=1
fi

if [ -n "$active_product_id" ] &&
   [ "$product_id" != "$active_product_id" ]; then
    log_msg "Touch firmware updater: Product ID mismatch!"
    log_msg "Hardware product id : $active_product_id"
    log_msg "Updater product id  : $product_id"
    return 1
fi

get_active_firmware_version

log_msg "Product ID : $product_id"
log_msg "Current Firmware: $active_fw_version"
log_msg "Updater Firmware: $fw_version"

if [ "$active_fw_version_major" -lt "$fw_version_major" ] ||
     ([ "$active_fw_version_major" -eq "$fw_version_major" ] &&
      [ "$active_fw_version_minor" -lt "$fw_version_minor" ]); then
    log_msg "Update needed."
    update_needed=1
fi

if [ "$active_fw_version_major" -eq "$fw_version_major" ] &&
   [ "$active_fw_version_minor" -eq "$fw_version_minor" ]; then
    log_msg "Firmware up to date."
elif [ $FLAGS_recovery -eq $FLAGS_TRUE ] &&
     [ $update_needed -eq 0 ]; then
    log_msg "Recovery firmware update. Rolling back to $fw_version."
    update_needed=1
fi

if [ $FLAGS_force -eq $FLAGS_TRUE ]; then
    log_msg "Forcing update."
fi

if [ $FLAGS_force -eq $FLAGS_TRUE ] ||
   [ $update_needed -eq 1 ]; then
    log_msg "Update FW to $fw_name"
    update_firmware
    get_active_firmware_version
    if [ "$active_fw_version_major" -ne "$fw_version_major" ] ||
       [ "$active_fw_version_minor" -ne "$fw_version_minor" ]; then
        log_msg "Firmware update failed."
        return 1
    fi
    log_msg "Update FW succeded. Current Firmware: $active_fw_version"
fi

return 0
