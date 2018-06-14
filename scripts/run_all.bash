#!/bin/bash
#set -e
#set -vx

clear

export LD_LIBRARY_PATH=/home/vagrant/frameworks/osip/src/osipparser2/.libs:$LD_LIBRARY_PATH

if ! [[ $1 =~ "^[0-9]+$" ]]
then
    COUNTER=$1
else
    COUNTER=1
fi

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

rm ../logs/merged.log.*

for i in $(seq 1 1 $COUNTER)
do
    LD_LIBRARY_PATH=/home/vagrant/frameworks/osip/src/osipparser2/.libs:$LD_LIBRARY_PATH ../bin/run_mtc.bash &
    LD_LIBRARY_PATH=/home/vagrant/frameworks/osip/src/osipparser2/.libs:$LD_LIBRARY_PATH ../bin/run_ptcs.bash

    dup=$(ps -ef | grep "$0" | grep -v grep | wc -l)
    while [ ${dup} -eq 3 ]
    do
        sleep 1
        dup=$(ps -ef | grep "$0" | grep -v grep | wc -l)
    done
    sleep 1
    
    mv ../logs/merged.log ../logs/merged.log.`date +'%Y%m%d%S'`
done

exit 0


