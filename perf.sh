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
  -h      (high)   Set performance profile and GPU min frequency to 1100 MHz.
  -m      (medium) Set power-saver profile and GPU min/max frequency to 550 MHz.
  -l      (low)    Set power-saver profile and GPU min/max frequency to 300 MHz.
  -s      (status) Check the profile status.
  --help           Show this help message."


GPU_MIN=$(cat /sys/class/drm/card0/gt_min_freq_mhz)
GPU_MAX=$(cat /sys/class/drm/card0/gt_max_freq_mhz)
CPU_PLAN=$(powerprofilesctl get)


if [[ $EUID -ne 0 ]]; then
    echo "--------------------------------------------------------------------------------"
   echo "This script requires root privileges"
   sudo "$0" "$@"
   exit 0
fi

case "$1" in
    "-h"|"--high")
        powerprofilesctl set performance
        echo 1100 > /sys/class/drm/card0/gt_max_freq_mhz
        echo 1100 > /sys/class/drm/card0/gt_min_freq_mhz
        echo "Performance mode enabled."
        echo "--------------------------------------------------------------------------------"
        exit 0
        ;;
    "-m"|"--medium")
        powerprofilesctl set balanced
        echo "If a error shows up, don't worry, everything is fine."
        echo 550 > /sys/class/drm/card0/gt_max_freq_mhz
        echo 550 > /sys/class/drm/card0/gt_min_freq_mhz
        echo 550 > /sys/class/drm/card0/gt_max_freq_mhz
        echo "Power-saver mode (medium) enabled."
        echo "--------------------------------------------------------------------------------"
        exit 0
        ;;
    "-l"|"--low")
        powerprofilesctl set power-saver
        echo 300 > /sys/class/drm/card0/gt_min_freq_mhz
        echo 300 > /sys/class/drm/card0/gt_max_freq_mhz
        echo "Power-saver mode (low) enabled."
        echo "--------------------------------------------------------------------------------"
        exit 0
        ;;
    "-s" | "--status")
        echo "GPU Min frequency: $GPU_MIN"
        echo "GPU Max frequency: $GPU_MAX"
        echo "CPU set powerplan: $CPU_PLAN"
        echo "--------------------------------------------------------------------------------"
        ;;
    *)
        echo "$HELP_MESSAGE"
        echo "--------------------------------------------------------------------------------"
        exit 1
        ;;
esac
