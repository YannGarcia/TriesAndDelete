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

make all
if [ "$1" == "d" ]
then 
    make run_d
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
