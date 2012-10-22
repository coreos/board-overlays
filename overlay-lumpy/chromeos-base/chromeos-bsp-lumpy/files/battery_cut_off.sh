#!/bin/bash
#
# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script sends I/O commands to EC to cut off the battery power.
# This is so called shipmode.
#
# The EC mailbox addresses: 0xA00 and 0xA01.
#

export IOTOOLS='iotools'

type $IOTOOLS &> /dev/null
if [ $? != 0 ]; then
  echo "FAILED, cannot find IOTOOLS ($IOTOOLS) in system."
  exit 1
fi

# check if EC is ready to accept next command
# If the return value of 0xA01 is 0, it's available.
# Exits after tried 10 times.
function EC_is_ready {
  AVAILABLE=
  for try in `seq 1 10`;
  do
    `$IOTOOLS io_write8 0xa00 0x82`
    AVAILABLE=`$IOTOOLS io_read8 0xa01`
    if [ "$AVAILABLE" = "0x00" ]; then
      break
    fi
    sleep 1
  done
  if [ "$AVAILABLE" != "0x00" ]; then
    echo "FAILED, timeout on getting EC available."
    exit 1
  fi
}


# main()

# 1. Check the EC is available.
EC_is_ready

# 2. Write the shipmode command (0x18)
`$IOTOOLS io_write8 0xa00 0x82`
`$IOTOOLS io_write8 0xa01 0x18`

# 3. Check the command is completed.
EC_is_ready

# 4. Check the returned value of command.
# If the return value of 0xA01 is 0xFA, it's OK. 0xFE means fail.
#   o 0xA00 0x84
#   i 0xA01
`$IOTOOLS io_write8 0xa00 0x84`
RETVAL=`$IOTOOLS io_read8 0xa01`
if [ "$RETVAL" = "0xfa" ]; then
  echo "SUCCESS"
  exit 0
else
  echo "FAILED"
  exit 1
fi
