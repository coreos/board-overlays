#!/bin/sh -e
#
# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Stumpy specific post USB reset wipe script. This will be run after OQC:
#   1. clean the activate date in VPD.
#   2. shut down the machine.

/usr/sbin/activate_date --clean
# remove the cached vpd log file so that the next reboot will re-generate it
# in /etc/init/vpd-log.conf.
VPD_2_0="/var/log/vpd_2.0.txt"
rm -f $VPD_2_0
sync
sleep 3

# You must put this line in the end of file.
/sbin/shutdown -h now

# It is regarded as shutdown failure that it isn't shut down within 5 mins.
sleep 5m
echo "The device isn't shutdown correctly."
exit 1
