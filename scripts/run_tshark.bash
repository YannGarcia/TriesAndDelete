#!/bin/bash

# Debug mode
set -evx

tshark -ienp0s3 -V -f"ether proto 0x8947" -Tfields -eframe.time -eeth.dst -eeth.src -eeth.type
