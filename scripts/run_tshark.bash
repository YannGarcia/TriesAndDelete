#!/bin/bash

# Debug mode
#set -vx
set -e

tshark -ienp0s8 -V -f"ether proto 0x8947" -Tfields -eframe.time -eeth.dst -eeth.src -eeth.type -edata
