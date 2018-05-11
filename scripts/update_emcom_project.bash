#!/bin/bash

# Debug mode
#set -e
#set -vx

# Usage: sudo ./update_emcom_project.bash
# TODO Use git clone in temporary directory

OLDPWD=`pwd`

# Execution path
RUN_PATH="${0%/*}"

UNAME=`uname -n`
if [ "${UNAME}" == "Ubuntu64" ]
then # Win7 Virtualbox Ubuntu 16.04
    CHOWN_USER_GROUP=yann:yann
    SRC_EMCOM_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
elif [ "${UNAME}" == "ubuntu-xenial" ]
then # Vqgrant xenial-ubuntu
    CHOWN_USER_GROUP=ubuntu:ubuntu
    SRC_EMCOM_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
elif [ "${UNAME}" == "vagrant" ]
then # Vagrant xenial-ubuntu
    CHOWN_USER_GROUP=vagrant:vagrant
    SRC_EMCOM_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
elif [ "${UNAME}" == "vagrant-prov" ]
then # Vagrant ubuntu 16.04 with provisioner script to automate ITS project build & test
    CHOWN_USER_GROUP=vagrant:vagrant
#    CHOWN_USER_GROUP=ubuntu:ubuntu
    SRC_EMCOM_PATH=${HOME}/tmp/STF549_ng112
elif [ "${UNAME}" == "yann-FSCOM" ]
then # Win7 cygwin64
    CHOWN_USER_GROUP=yann:None
    SRC_EMCOM_PATH=/cygdrive/f/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
else # docket-titan
    CHOWN_USER_GROUP=root:root
    SRC_EMCOM_PATH=${HOME}/tmp/STF549_ng112
fi
if [ "${PATH_DEV_EMCOM}" == "" ]
then
    PATH_DEV_EMCOM=`pwd`/../etsi_emcom
fi

if [ -d ${PATH_DEV_EMCOM} ]
then
    if [ -f ${HOME}/tmp/emcom.tar.bz2 ]
    then
	      mv ${HOME}/tmp/emcom.tar.bz2 ${HOME}/tmp/emcom.tar.`date +'%Y%m%d'`.bz2
    fi
    find ${PATH_DEV_EMCOM} -name "*.o" -exec rm {} \;
    tar jcvf ${HOME}/tmp/emcom.tar.bz2 ${PATH_DEV_EMCOM}
    rm -fr ${PATH_DEV_EMCOM}
fi

# Check if target directory exist
if [ ! -d ${PATH_DEV_EMCOM} ]
then
    mkdir -p ${PATH_DEV_EMCOM}/xsd ${PATH_DEV_EMCOM}/framework ${PATH_DEV_EMCOM}/include ${PATH_DEV_EMCOM}/bin ${PATH_DEV_EMCOM}/lib ${PATH_DEV_EMCOM}/objs ${PATH_DEV_EMCOM}/src ${PATH_DEV_EMCOM}/docs
fi

# Update XSD files
echo 'Updating XSD files'
XSD_SRC_PATH=${SRC_EMCOM_PATH}/xsd
XSD_DST_PATH=${PATH_DEV_EMCOM}/xsd
cp ${XSD_SRC_PATH}/*.xsd ${XSD_DST_PATH}
cp ${XSD_SRC_PATH}/*.dtd ${XSD_DST_PATH}

# Update ETSI Framework files
echo 'Updating ETSI Framework files'
FWK_SRC_PATH=${SRC_EMCOM_PATH}/ccsrc
FWK_DST_PATH=${PATH_DEV_EMCOM}/framework
mkdir -p ${FWK_DST_PATH}/src ${FWK_DST_PATH}/include
chmod -R 775 ${FWK_DST_PATH}
# Create link to TITAN Abstract_Socket
ln -sf $TOP/../titan.TestPorts.Common_Components.Abstract_Socket/src/Abstract_Socket.cc ${FWK_DST_PATH}/src/Abstract_Socket.cc
ln -sf $TOP/../titan.TestPorts.Common_Components.Abstract_Socket/src/Abstract_Socket.hh ${FWK_DST_PATH}/include/Abstract_Socket.hh
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Protocols/ -name "*.h*" -type f`
FWK_DIR_LIST_THH=`find ${FWK_SRC_PATH}/Protocols/ -name "*.t.h*" -type f`
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Protocols/ -name "*.c*" -type f`
FWK_DIR_LIST_L=`find ${FWK_SRC_PATH}/Protocols/ -name "*.l" -type f`
FWK_DIR_LIST_Y=`find ${FWK_SRC_PATH}/Protocols/ -name "*.y" -type f`
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
if [ "${FWK_DIR_LIST_L}" != "" ]
then
    for i in ${FWK_DIR_LIST_L}
    do
	      cp $i ${FWK_DST_PATH}/src
    done
fi
if [ "${FWK_DIR_LIST_Y}" != "" ]
then
    for i in ${FWK_DIR_LIST_Y}
    do
	      cp $i ${FWK_DST_PATH}/src
    done
fi
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
TTCN_3_ORG_PATH=${SRC_EMCOM_PATH}/ttcn
TTCN_3_DST_PATH=${PATH_DEV_EMCOM}/src
CC_SRC_PATH=${SRC_EMCOM_PATH}/ccsrc
TTCN_3_ATS_LIST='AtsNg112 TestCodec'
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
TTCN_3_LIB_LIST='LibEmcom/LibNg112 LibHttp LibSip LibCommon'
for i in ${TTCN_3_LIB_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/$i ]
    then
	      mkdir -p ${TTCN_3_DST_PATH}/$i/docs ${TTCN_3_DST_PATH}/$i/src ${TTCN_3_DST_PATH}/$i/include ${TTCN_3_DST_PATH}/$i/ttcn ${TTCN_3_DST_PATH}/$i/xsd
    fi
    cp ${TTCN_3_ORG_PATH}/$i/*.ttcn ${TTCN_3_DST_PATH}/$i/ttcn
    # Update CC files
    if [ "$i" == "LibNg112" ]
    then
	      cp ${CC_SRC_PATH}/include/$i/*.hh ${TTCN_3_DST_PATH}/$i/include
	      cp ${CC_SRC_PATH}/src/$i/*.cc ${TTCN_3_DST_PATH}/$i/src
    fi
    if [ "$i" == "LibSip" ]
    then
        cp ${TTCN_3_ORG_PATH}/$i/ttcn/*.ttcn ${TTCN_3_DST_PATH}/$i/ttcn
        cp ${TTCN_3_ORG_PATH}/$i/xsd/*.xsd ${TTCN_3_DST_PATH}/$i/xsd
        cp ${TTCN_3_ORG_PATH}/$i/xsd/*.ttcn ${TTCN_3_DST_PATH}/$i/ttcn
	      cp ${CC_SRC_PATH}/EncDec/$i/*_Encdec.cc ${TTCN_3_DST_PATH}/$i/src
	      cp ${CC_SRC_PATH}/Ports/$i/*.hh ${TTCN_3_DST_PATH}/$i/include
	      cp ${CC_SRC_PATH}/Ports/$i/*.cc ${TTCN_3_DST_PATH}/$i/src
	      cp ${CC_SRC_PATH}/include/$i/*.hh ${TTCN_3_DST_PATH}/$i/include
	      cp ${CC_SRC_PATH}/src/$i/*.cc ${TTCN_3_DST_PATH}/$i/src
    fi
done

# Generate Bison parsers is any
#cd ${FWK_DST_PATH}/src
#if [ "${FWK_DIR_LIST_Y}" != "" ]
#then
#    for i in ${FWK_DIR_LIST_Y}
#    do
#        BASE_NAME=$(basename "$i" .y)
#        bison -dv -p${BASE_NAME}_ -b${BASE_NAME}_ ${BASE_NAME}.y #--defines=../include/${BASE_NAME}.h -o${BASE_NAME}.c
#    done
#fi
#if [ "${FWK_DIR_LIST_L}" != "" ]
#then
#    for i in ${FWK_DIR_LIST_L}
#    do
#        BASE_NAME=$(basename "$i" .l)
#        flex -Cfr -8 -Bvpp -P${BASE_NAME}_ ${BASE_NAME}.l  # -o${BASE_NAME}_flex.c ${BASE_NAME}.l
#    done
#    mv ${BASE_NAME}_.tab.h ../include
#fi
#cd -

# Apply patches
PATH_PATCHES=`pwd`/etsi_emcom_patches
if [ -d ${PATH_PATCHES} ]
then
    cp ${PATH_PATCHES}/ng112.bash ${PATH_DEV_EMCOM}/src/AtsNg112/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_EMCOM}/src/AtsNg112/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_EMCOM}/src/AtsNg112/bin
    cp ${PATH_PATCHES}/../run_all.bash ${PATH_DEV_EMCOM}/src/AtsNg112/bin
fi

# Set rights
find ${PATH_DEV_EMCOM} -type f -exec chmod 664 {} \;
find ${PATH_DEV_EMCOM} -name "*.bash" -type f -exec chmod 775 {} \;
find ${PATH_DEV_EMCOM} -type d -exec chmod 775 {} \;
chown -R ${CHOWN_USER_GROUP} ${PATH_DEV_EMCOM}

cd ${OLDPWD}

exit 0
