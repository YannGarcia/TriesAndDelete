#!/bin/bash
#set -x

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

if [ -f ./core ]
then
    rm -f ./core
fi
if [ "$1" == "d" ]
then 
    make run_d
elif [ "$1" == "v" ]
     make run_v
else
    make run
fi
#if [ "${OSTYPE}" == "cygwin" ]
#then
#    ../bin/SIPmsg.exe 127.0.0.1 12000
#else
#    ../bin/SIPmsg 127.0.0.1 12000
#fi

cd ${CURPWD}
