#/bin/bash
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

export CFG_FILES=`find .. -name '*.cfg'`
export LOG_FILES=`find .. -name '*.log'`
#rm ${LOG_FILES} /tmp/internal_tri.log

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
mctr ${CFG_FILES} 2>&1 3>&1 | tee ./console.log

export LOG_FILES=`find .. -name '*.log'`
tcn3_logmerge -o merged.log ${LOG_FILES} # /tmp/internal_tri.log

cd ${CURPWD}
