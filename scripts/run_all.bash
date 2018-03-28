#!/bin/bash
set -e
#set -vx

clear

CURPWD=`pwd`
if [ ! "${PWD##*/}" == "objs" ]
then
    cd ../objs
    if [ ! $? == 0 ]
    then
        echo "Please move to PROJECT/obj directory"
        exit 1
    fi
fi

../bin/run_mtc.bash &

../bin/run_ptcs.bash

exit 0


