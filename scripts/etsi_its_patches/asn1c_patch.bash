#!/bin/bash
set -x

function f_exit {
    cd ${CURPWD}
    
    unset TTCN_FILES
    unset CC_FILES
    unset CFG_FILES
    unset EXECUTABLE
    echo $1
    exit $2
}

function f_usage {
    echo "asn1c_patch.bash: This script import from External Disk the "
    echo "Arguments:"
    echo "  <makefile>: Full path to the makefile to patch"
    exit 0
}

#clear

if [ "$1" == "help" ]
then
    f_usage
fi

# Patch ATS generated files

ADD_CFLAGS='s/CONVERTER=converter/CFLAGS+= -O0 -ggdb -fPIC\n\rCONVERTER=converter/g'
sed --in-place "${ADD_CFLAGS}" $1 
f_exit "Build done successfully" 0
