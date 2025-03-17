# perf.sh - Power Saver Script for Thinkpad T480

This script is a power-saver designed for the Thinkpad T480. It allows you to set the system performance profile and GPU frequency on Linux.

## Dependencies

This script requires `power-profiles-daemon` to be installed.

## Usage

```bash
./perf.sh [option]
```

## Options

*   `-h`: (high)   Set performance profile and GPU min frequency to 1100 MHz
*   `-m`: (medium) Set balanced power profile and GPU min/max frequency to 550 MHz
*   `-l`: (low)    Set power-saver profile and GPU min/max frequency to 300 MHz
*   `--help`:      Show this help message
