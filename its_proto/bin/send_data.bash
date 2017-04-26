#!/bin/bash
set -x
echo 'MyPCO2_PT: Hello, world!' | nc -4u -q1 localhost 12345 
