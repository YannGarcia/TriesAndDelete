#!/bin/bash

# Debug mode
#set -e
set -vx

# Usage: sudo ./update_emtel_project.bash
# TODO Use git clone in temporary directory

OLDPWD=`pwd`

# Execution path
RUN_PATH="${0%/*}"

UNAME=`uname -n`
if [ "${UNAME}" == "Ubuntu64" ]
then # Win7 Virtualbox Ubuntu 16.04
    CHOWN_USER_GROUP=yann:yann
    SRC_EMTEL_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMTEL/STF549/workspace_titan/STF549
elif [ "${UNAME}" == "ubuntu-xenial" ]
then # Vqgrant xenial-ubuntu
    CHOWN_USER_GROUP=ubuntu:ubuntu
    SRC_EMTEL_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMTEL/STF549/workspace_titan/STF549
elif [ "${UNAME}" == "vagrant" ]
then # Vagrant xenial-ubuntu
    CHOWN_USER_GROUP=vagrant:vagrant
    SRC_EMTEL_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMTEL/STF549/workspace_titan/STF549
elif [ "${UNAME}" == "vagrant-prov" ]
then # Vagrant ubuntu 16.04 with provisioner script to automate ITS project build & test
    CHOWN_USER_GROUP=vagrant:vagrant
#    CHOWN_USER_GROUP=ubuntu:ubuntu
    SRC_EMTEL_PATH=${HOME}/tmp/STF549
elif [ "${UNAME}" == "yann-FSCOM" ]
then # Win7 cygwin64
    CHOWN_USER_GROUP=yann:None
    SRC_EMTEL_PATH=/cygdrive/f/FSCOM/ETSI/EMTEL/STF549/workspace_titan/STF549
else # docket-titan
    CHOWN_USER_GROUP=root:root
    SRC_EMTEL_PATH=${HOME}/tmp/STF549
fi
if [ "${PATH_DEV_EMTEL}" == "" ]
then
    PATH_DEV_EMTEL=`pwd`/../emtel
fi

if [ -d ${PATH_DEV_EMTEL} ]
then
    if [ -f ${HOME}/tmp/emtel.tar.bz2 ]
    then
	      rm ${HOME}/tmp/emtel.tar.bz2
    fi
    tar jcvf ${HOME}/tmp/emtel.tar.bz2 ${PATH_DEV_EMTEL}
    rm -fr ${PATH_DEV_EMTEL}
fi

# Check if target directory exist
if [ ! -d ${PATH_DEV_EMTEL} ]
then
    mkdir -p ${PATH_DEV_EMTEL}/xsd ${PATH_DEV_EMTEL}/framework ${PATH_DEV_EMTEL}/include ${PATH_DEV_EMTEL}/bin ${PATH_DEV_EMTEL}/lib ${PATH_DEV_EMTEL}/objs ${PATH_DEV_EMTEL}/src ${PATH_DEV_EMTEL}/docs
fi

# Update XSD files
echo 'Updating XSD files'
XSD_SRC_PATH=${SRC_EMTEL_PATH}/xsd
XSD_DST_PATH=${PATH_DEV_EMTEL}/xsd
cp ${XSD_SRC_PATH}/*.xsd ${XSD_DST_PATH}
cp ${XSD_SRC_PATH}/*.dtd ${XSD_DST_PATH}

# Update ETSI Framework files
echo 'Updating ETSI Framework files'
FWK_SRC_PATH=${SRC_EMTEL_PATH}/ccsrc
FWK_DST_PATH=${PATH_DEV_EMTEL}/framework
mkdir -p ${FWK_DST_PATH}/src ${FWK_DST_PATH}/include
chmod -R 775 ${FWK_DST_PATH}
# Create link to TITAN Abstract_Socket
ln -sf $TOP/../titan.TestPorts.Common_Components.Abstract_Socket/src/Abstract_Socket.cc ${FWK_DST_PATH}/src/Abstract_Socket.cc
ln -sf $TOP/../titan.TestPorts.Common_Components.Abstract_Socket/src/Abstract_Socket.hh ${FWK_DST_PATH}/include/Abstract_Socket.hh
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Protocols/ -name "*.h*" -type f`
FWK_DIR_LIST_THH=`find ${FWK_SRC_PATH}/Protocols/ -name "*.t.h*" -type f`
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Protocols/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
	  cp $i ${FWK_DST_PATH}/include
done
for i in ${FWK_DIR_LIST_THH}
do
	  cp $i ${FWK_DST_PATH}/include
done
for i in ${FWK_DIR_LIST_CC}
do
	  cp $i ${FWK_DST_PATH}/src
done
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Framework/ -name "*.h*" -type f`
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Framework/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
    cp $i ${FWK_DST_PATH}/include
done
for i in ${FWK_DIR_LIST_CC}
do
    cp $i ${FWK_DST_PATH}/src
done

# Update ATS TTCN-3 files
echo 'Update TTCN-3 files'
TTCN_3_ORG_PATH=${SRC_EMTEL_PATH}/ttcn
TTCN_3_DST_PATH=${PATH_DEV_EMTEL}/src
CC_SRC_PATH=${SRC_EMTEL_PATH}/ccsrc
TTCN_3_ATS_LIST='AtsPemea'
for i in ${TTCN_3_ATS_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/$i ]
    then
	      mkdir -p ${TTCN_3_DST_PATH}/$i/bin ${TTCN_3_DST_PATH}/$i/lib ${TTCN_3_DST_PATH}/$i/src ${TTCN_3_DST_PATH}/$i/include ${TTCN_3_DST_PATH}/$i/ttcn ${TTCN_3_DST_PATH}/$i/objs ${TTCN_3_DST_PATH}/$i/etc ${TTCN_3_DST_PATH}/$i/docs
	      chmod -R 775 ${TTCN_3_DST_PATH}/$i
    fi
    cp ${TTCN_3_ORG_PATH}/$i/*.ttcn ${TTCN_3_DST_PATH}/$i/ttcn
    cp ${TTCN_3_ORG_PATH}/../etc/$i/*.cfg ${TTCN_3_DST_PATH}/$i/etc
    cp ${TTCN_3_ORG_PATH}/../docs/$i/o2.cfg ${TTCN_3_DST_PATH}/$i/docs
done

# Update libraries & CC files
TTCN_3_LIB_LIST='LibPemea LibHttp LibCommon'
for i in ${TTCN_3_LIB_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/$i ]
    then
	      mkdir -p ${TTCN_3_DST_PATH}/$i/docs ${TTCN_3_DST_PATH}/$i/src ${TTCN_3_DST_PATH}/$i/include ${TTCN_3_DST_PATH}/$i/ttcn
    fi
    cp ${TTCN_3_ORG_PATH}/$i/*.ttcn ${TTCN_3_DST_PATH}/$i/ttcn
    # Update CC files
    if [ "$i" == "LibPemea" ]
    then
	      cp ${CC_SRC_PATH}/include/$i/*.hh ${TTCN_3_DST_PATH}/$i/include
	      cp ${CC_SRC_PATH}/src/$i/*.cc ${TTCN_3_DST_PATH}/$i/src
    fi
done

# Apply patches
PATH_PATCHES=`pwd`/etsi_emtel_patches
if [ -d ${PATH_PATCHES} ]
then
    cp ${PATH_PATCHES}/pemea.bash ${PATH_DEV_EMTEL}/src/AtsPemea/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_EMTEL}/src/AtsPemea/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_EMTEL}/src/AtsPemea/bin
fi

# Set rights
find ${PATH_DEV_EMTEL} -type f -exec chmod 664 {} \;
find ${PATH_DEV_EMTEL} -name "*.bash" -type f -exec chmod 775 {} \;
find ${PATH_DEV_EMTEL} -type d -exec chmod 775 {} \;
chown -R ${CHOWN_USER_GROUP} ${PATH_DEV_EMTEL}

cd ${OLDPWD}

exit 0
