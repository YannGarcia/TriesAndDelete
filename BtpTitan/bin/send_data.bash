#!/bin/bash
set -x
echo '07d10000010200008235c92a4056b49d200d693a401ffffffc2030d41e00000fc0007e83109d0737530f1fffb0000000' | xxd -r -p | nc -u localhost 12345 