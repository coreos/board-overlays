#!/bin/bash
# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Quick hack to monitor thermals on snow platform. Since we only have
# passive cooling, the only thing we can do is limit CPU temp.
#
# TODO: validate readings from thermistors by comparing to each other.
#       We should ignore readings with more than 10C differences from peers.

PROG=`basename $0`

let debug=0
if [[ "$1x" = '-dx' ]] ; then
    let debug=1
fi

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
# 1700000 1600000 1500000 ...
declare -a EXYNOS5_CPU_FREQ=(1700000 1600000 1500000 1400000 1300000 \
    1200000 1100000 1000000 900000 800000 700000 600000 500000 400000 \
    300000 200000)

# CPU temperature threshold we start limiting CPU Freq
# 63 -> 1.4Ghz, 69 -> 1.1 Ghz, 75 -> 800Mhz
declare -a CPU_TEMP_MAP=(60 61 62 63 65 67 68 69 71 73 75)
declare -a DAISY_CPU_TEMP=("/sys/class/thermal/thermal_zone0/temp")

# 52 -> 1.4Ghz, 60->1.1Ghz, 65->800Mhz
declare -a THERMISTOR_TEMP_MAP=(49 50 51 52 55 58 60 62 64 65)
declare -a DAISY_THERMISTOR_TEMP=( \
    "/sys/devices/platform/ncp15wb473.0/temp1_input" \
    "/sys/devices/platform/ncp15wb473.1/temp1_input" \
    "/sys/devices/platform/ncp15wb473.2/temp1_input" \
    "/sys/devices/platform/ncp15wb473.3/temp1_input")


read_temp() {
    sensor="$1"
    if [[ -r $sensor ]] ; then
        # treat $1 as numeric and convert to C
        local raw
        raw=`cat $sensor 2> /dev/null`
        if [[ -z "$raw" ]] ; then
            return 1
        fi
        let t=$raw/1000

        # valid CPU range is 25 to 125C. Give thermistor more range.
        if  [[ $t -lt 15 || $t -gt 140 ]] ; then
            # do nothing - ignore the reading
            logger -t "$PROG" "ERROR: temp $t out of range"
            return 1
        fi
        return $t
    fi

    logger -t "$PROG" "ERROR: could not read temp from $sensor"
    # sleep so script isn't respawned so quickly and spew
    sleep 10
    exit 1
}

lookup_freq_idx() {
    let t=$1
    shift
    declare -a temp_map=(${*})
    let i=0
    let n=${#temp_map[@]}

    while [[ $i -lt $n ]]
    do
        if [[ $t -le ${temp_map[i]} ]] ; then
            return $i
        fi
        let i+=1
    done

    # we ran off the end of the map. Use slowest speed in that map.
    logger -t "$PROG" "ERROR: temp $t not in temp_map"
    let i=$n-1
    return $i
}

# Thermal loop steps
set_max_cpu_freq() {
    max_freq=$1
    for cpu in /sys/devices/system/cpu/cpu?/cpufreq; do
        echo $max_freq > $cpu/scaling_max_freq
    done
}

# Only update cpu Freq if we need to change.
let last_cpu_freq=0

while true; do
    max_cpu_freq=${EXYNOS5_CPU_FREQ[0]}
    # read the list of temp sensors
    for sensor in ${DAISY_CPU_TEMP[*]}
    do
        read_temp $sensor
        let cpu_temp=$?

        lookup_freq_idx $cpu_temp "${CPU_TEMP_MAP[@]}"
        let f=$?
        let cpu_freq=${EXYNOS5_CPU_FREQ[f]}

        if [[ $cpu_freq -gt 0 && $cpu_freq -lt $max_cpu_freq ]] ; then
            max_cpu_freq=$cpu_freq
        fi
    done

    let j=0
    declare -a temps
    for sensor in ${DAISY_THERMISTOR_TEMP[*]}
    do
        read_temp $sensor
        let temp=$?

        # record temps for (DEBUG and) validation later
        temps[$j]=$temp
        let j+=1
    done

    # TODO validate thermistor readings.
    # we should reject anything that is more than 5C off from all others.
    let max_temp=${temps[0]}
    for k in `seq 1 $j`
    do
        if [[ $max_temp -lt ${temps[k]} ]] ; then
            let max_temp=${temps[k]}
        fi
    done

    lookup_freq_idx $max_temp "${THERMISTOR_TEMP_MAP[@]}"
    let f=$?
    let therm_cpu_freq=${EXYNOS5_CPU_FREQ[f]}

    # we have a valid reading and it's lower than others
    if [[ $therm_cpu_freq -gt 0 && $therm_cpu_freq -lt $max_cpu_freq ]] ; then
        max_cpu_freq=$therm_cpu_freq
    fi

    if [[ debug -gt 0 ]] ; then
        echo `date +"%H:%M:%S"` , \
            `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`, \
            $max_cpu_freq , $cpu_temp, ${temps[@]}
    fi

    if [[ $last_cpu_freq -ne $max_cpu_freq ]] ; then
        let last_cpu_freq=$max_cpu_freq
        set_max_cpu_freq $max_cpu_freq
    fi

    sleep 15
done
