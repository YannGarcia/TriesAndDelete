#/bin/bash
set -x

clear

if [ -z "${TOP}" ]
then
    echo "Failed, TOP variable not defined, exit"
    exit 1
fi

CURDIR=`pwd`
TITAN_DIR=${TOP}/..

# Move to the right directory
if [ ! -d ${TITAN_DIR} ]
then
    echo "Titan directory does not exist, create it"
    # Create TITAN directories
    mkdir -p ${TITAN_DIR}
    if [ ! "$?" -eq "0" ]
    then
        echo "Failed, TOP variable not defined, exit"
        exit 2
    fi
    cd ${TITAN_DIR}
    # Clone all TITAN repositories
    if [ ! -f ${HOME_BIN}/titan_repos.txt ]
    then
        echo "${HOME_BIN}/titan_repos.txt file does not exist, exit"
        rm -fr ${TOP}
        rm -fr ${TOP}/..
        exit 3
    fi
    TITAN_REPOS=`cat ${HOME_BIN}/titan_repos.txt`
    for i in ${TITAN_REPOS};
    do
        git clone $i
        if [ ! "$?" -eq "0" ]
        then
            echo "Failed to clone $i, exit"
            exit 4
        fi
    done
else
    cd ${TITAN_DIR}
    # Update github folders
    DIRS=`find . -type d -name ".git" -exec dirname {} \;`
    for i in ${DIRS};
    do
        echo "Processing $i..."
        cd $i
        git fetch
        if [ ! "$?" -eq "0" ]
        then
            echo "Failed to fetch $i, continue"
        else 
            git pull
            if [ ! "$?" -eq "0" ]
            then
        echo "Failed to pull $i, continue"
            fi
    fi
        cd -
    done
fi

# Build TITAN core
cd ./titan.core
echo "Starting build..."
make clean
if [ "${OSTYPE}" == "cygwin" ]
then
    make -j
else
    make
fi
make install
echo "Build done"

# Go back to initial directory
cd ${CURDIR}
exit 0
