#/bin/bash
set -x

clear

TITAN_LOG_DIR=../log
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

CFG_FILES=`find .. -name '*.cfg'`
if [ ! -d ../logs ]
then
    mkdir ../logs
fi
LOG_FILES=`find ${TITAN_LOG_DIR} -name '*.log'`
mv ${LOG_FILES} ../logs

#if [ "${OSTYPE}" == "cygwin" ]
#then
#    # Remove dll
#    rm ./*.dll
#    ## Copy the new ones
#    cp ~/lib/libhelper.dll .
#    cp ~/lib/libconverter.dll .
#    cp ~/lib/liblogger.dll .
#    cp ~/lib/libttcn3_tri.dll .
#    cp ~/lib/libcomm.dll .
#fi

echo "> cmtc: to create the MTC server"
echo "> smtc [module_name[[.control]|.testcase_name|.*]: when MyExample is connected, run the TCs in [EXECUTE] section"
echo "> emtc: Terminate MTC."
mctr ${CFG_FILES}

LOG_FILES=`find ${TITAN_LOG_DIR} -name '*.log'`
ttcn3_logmerge -o ${TITAN_LOG_DIR}/merged.log ${LOG_FILES}
echo "log files were merged into ${TITAN_LOG_DIR}/merged.log"

cd ${CURPWD}
