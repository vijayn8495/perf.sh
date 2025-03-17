#!/bin/bash

########################################################################################
#                   __      _                                                          #
#  _ __   ___ _ __ / _| ___| |__                                                       #
# | '_ \ / _ \ '__| |_ / __| '_ \                                                      #
# | |_) |  __/ |  |  _|\__ \ | | |                                                     #
# | .__/ \___|_|  |_|(_)___/_| |_|                                                     #
# |_|                                                                                  #
#                                                                                      #
#                                                                                      #
# Power-saver script to set system performance, designed for the Thinkpad T480         #
# CPU: Intel(R) Core(TM) i5-8350U (8) @ 3.60 GHz                                       #
# GPU: Intel UHD Graphics 620 @ 1.10 GHz                                               #
#
########################################################################################

HELP_MESSAGE="Usage: perf.sh [option]
Options:
  -h      (high)   Set performance profile and GPU min frequency to 1100 MHz
  -m      (medium) Set power-saver profile and GPU min/max frequency to 550 MHz
  -l      (low)    Set power-saver profile and GPU min/max frequency to 300 MHz
  --help           Show this help message"

if [ "$1" == "--help" ]; then
    echo "$HELP_MESSAGE"
    exit 0
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script requires root privileges."
   sudo "$0" "$@"
   exit 0
fi

if [ "$1" == "-h" ]; then
    powerprofilesctl set performance
    echo 1100 > /sys/class/drm/card0/gt_min_freq_mhz
    echo "Performance mode enabled"
    exit 0
elif [ "$1" == "-m" ]; then
    powerprofilesctl set balanced
    echo 550 > /sys/class/drm/card0/gt_min_freq_mhz
    echo 550 > /sys/class/drm/card0/gt_max_freq_mhz
    echo "Power-saver mode (medium) enabled"
    exit 0
elif [ "$1" == "-l" ]; then
    powerprofilesctl set power-saver
    echo 300 > /sys/class/drm/card0/gt_min_freq_mhz
    echo 300 > /sys/class/drm/card0/gt_max_freq_mhz
    echo "Power-saver mode (low) enabled"
    exit 0
else
    echo "$HELP_MESSAGE"
    exit 1
fi
