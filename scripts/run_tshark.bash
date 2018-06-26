#!/bin/bash

# Debug mode
#set -vx
set -e

~/frameworks/wireshark-build/run/tshark -ieth1 -V -f"ether proto 0x8947 or udp src port 12345 or udp dst port 12345" -Tfields -eframe.time -eeth.dst -eeth.src -eeth.type -edata
