#!/bin/bash

# Debug mode
#set -e
set -vx

# Usage: sudo ./merge_emcom_project.bash
# TODO Use git clone in temporary directory

OLDPWD=`pwd`

# Storing path
VAGRANT_DIR=/vagrant
if [ ! -d ${VAGRANT_DIR} ]
then
	  exit -1
else
	  VAGRANT_DIR=/vagrant/to_be_merged
	  if [ -d ${VAGRANT_DIR} ]
	  then
	      rm -f ${VAGRANT_DIR}/*
	  else
	          mkdir ${VAGRANT_DIR}
	  fi
fi

# Execution path
RUN_PATH="${0%/*}"
UNAME=`uname -n`
if [ "${UNAME}" == "Ubuntu64" ]
then # Win7 Virtualbox Ubuntu 16.04
    SRC_EMCOM_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
elif [ "${UNAME}" == "ubuntu-xenial" ]
then # Vqgrant xenial-ubuntu
    SRC_EMCOM_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
elif [ "${UNAME}" == "vagrant" ]
then # Vagrant xenial-ubuntu
    SRC_EMCOM_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
elif [ "${UNAME}" == "vagrant-prov" ]
then # Vagrant ubuntu 16.04 with provisioner script to automate EMCOM project build & test
#    CHOWN_USER_GROUP=ubuntu:ubuntu
    SRC_EMCOM_PATH=${HOME}/tmp/STF549
elif [ "${UNAME}" == "yann-FSCOM" ]
then # Win7 cygwin64
    SRC_EMCOM_PATH=/cygdrive/f/FSCOM/ETSI/EMCOM/STF549/workspace_titan/STF549_ng112
else # docket-titan
    SRC_EMCOM_PATH=${HOME}/tmp/STF549_ng112
fi
if [ "${PATH_DEV_EMCOM}" == "" ]
then
    PATH_DEV_EMCOM=`pwd`/../etsi_emcom
fi

# Update ETSI Framework files
echo 'Merging ETSI Framework files'
FWK_SRC_PATH=${SRC_EMCOM_PATH}/ccsrc
FWK_DST_PATH=${PATH_DEV_EMCOM}/framework
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Protocols/ -name "*.h*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
    BN=`basename $i`
	  s1=`sha256sum -b $i | cut -d' ' -f1`
	  s2=`sha256sum -b ${FWK_DST_PATH}/include/${BN} | cut -d' ' -f1`
	  if [ "${s1}" != "${s2}" ]
	  then
	      cp ${FWK_DST_PATH}/include/${BN} ${VAGRANT_DIR}
	      if [ -f ${FWK_DST_PATH}/include/${BN}~ ]
	      then
		        rm ${FWK_DST_PATH}/include/${BN}~
	      fi
	  fi
done
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Protocols/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_CC}
do
    BN=`basename $i`
	  s1=`sha256sum -b $i | cut -d' ' -f1`
	  s2=`sha256sum -b ${FWK_DST_PATH}/src/${BN} | cut -d' ' -f1`
	  if [ "${s1}" != "${s2}" ]
	  then
	      cp ${FWK_DST_PATH}/src/${BN} ${VAGRANT_DIR}
	      if [ -f ${FWK_DST_PATH}/src/${BN}~ ]
	      then
		        rm ${FWK_DST_PATH}/src/${BN}~
	      fi
	  fi
done
FWK_DIR_LIST_Y=`find ${FWK_SRC_PATH}/Protocols/ -name "*.y" -type f`
for i in ${FWK_DIR_LIST_Y}
do
    BN=`basename $i`
	  s1=`sha256sum -b $i | cut -d' ' -f1`
	  s2=`sha256sum -b ${FWK_DST_PATH}/src/${BN} | cut -d' ' -f1`
	  if [ "${s1}" != "${s2}" ]
	  then
	      cp ${FWK_DST_PATH}/src/${BN} ${VAGRANT_DIR}
	      if [ -f ${FWK_DST_PATH}/src/${BN}~ ]
	      then
		        rm ${FWK_DST_PATH}/src/${BN}~
	      fi
	  fi
done
FWK_DIR_LIST_L=`find ${FWK_SRC_PATH}/Protocols/ -name "*.l" -type f`
for i in ${FWK_DIR_LIST_L}
do
    BN=`basename $i`
	  s1=`sha256sum -b $i | cut -d' ' -f1`
	  s2=`sha256sum -b ${FWK_DST_PATH}/src/${BN} | cut -d' ' -f1`
	  if [ "${s1}" != "${s2}" ]
	  then
	      cp ${FWK_DST_PATH}/src/${BN} ${VAGRANT_DIR}
	      if [ -f ${FWK_DST_PATH}/src/${BN}~ ]
	      then
		        rm ${FWK_DST_PATH}/src/${BN}~
	      fi
	  fi
done
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Framework/ -name "*.h*" -type f`
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Framework/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
    BN=`basename $i`
    s1=`sha256sum -b $i | cut -d' ' -f1`
    s2=`sha256sum -b ${FWK_DST_PATH}/include/${BN} | cut -d' ' -f1`
    if [ "${s1}" != "${s2}" ]
    then
	      cp ${FWK_DST_PATH}/include/${BN} ${VAGRANT_DIR} 
	      if [ -f ${FWK_DST_PATH}/include/${BN}~ ]
	      then
	          rm ${FWK_DST_PATH}/include/${BN}~
	      fi
    fi
done
for i in ${FWK_DIR_LIST_CC}
do
    BN=`basename $i`
    s1=`sha256sum -b $i | cut -d' ' -f1`
    s2=`sha256sum -b ${FWK_DST_PATH}/src/${BN} | cut -d' ' -f1`
    if [ "${s1}" != "${s2}" ]
    then
	      cp ${FWK_DST_PATH}/src/${BN} ${VAGRANT_DIR}
	      if [ -f ${FWK_DST_PATH}/src/${BN}~ ]
	      then
	          rm ${FWK_DST_PATH}/src/${BN}~
	      fi
    fi
done
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/loggers/ -name "*.h*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
    BN=`basename $i`
    s1=`sha256sum -b $i | cut -d' ' -f1`
    s2=`sha256sum -b ${FWK_DST_PATH}/include/${BN} | cut -d' ' -f1`
    if [ "${s1}" != "${s2}" ]
    then
	      cp ${FWK_DST_PATH}/include/${BN} ${VAGRANT_DIR}
	      if [ -f ${FWK_DST_PATH}/include/${BN}~ ]
	      then
	          rm ${FWK_DST_PATH}/include/${BN}~
	      fi
    fi
done
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/loggers/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_CC}
do
    BN=`basename $i`
    s1=`sha256sum -b $i | cut -d' ' -f1`
    s2=`sha256sum -b ${FWK_DST_PATH}/src/${BN} | cut -d' ' -f1`
    if [ "${s1}" != "${s2}" ]
    then
	      cp ${FWK_DST_PATH}/src/${BN} ${VAGRANT_DIR}
	      if [ -f ${FWK_DST_PATH}/src/${BN}~ ]
	      then
	          rm ${FWK_DST_PATH}/src/${BN}~
	      fi
    fi
done
# Update ATS TTCN-3 files
echo 'Update TTCN-3 files'
TTCN_3_ORG_PATH=${SRC_EMCOM_PATH}/ttcn
TTCN_3_DST_PATH=${PATH_DEV_EMCOM}/src
TTCN_3_ATS_LIST='AtsNg112 LibEmcom/LibNg112 LibCommon LibSip LibItsHttp'
for i in ${TTCN_3_ATS_LIST}
do
    # TTCN-3 files
    LIST_TTCN_FILES=`find ${TTCN_3_ORG_PATH}/$i -name "*.ttcn" -type f`
    for j in ${LIST_TTCN_FILES}
    do
	      BN=`basename $j`
	      s1=`sha256sum -b $j | cut -d' ' -f1`
	      s2=`sha256sum -b ${TTCN_3_DST_PATH}/$i/ttcn/${BN} | cut -d' ' -f1`
	      if [ "${s1}" != "${s2}" ]
	      then
	          cp ${TTCN_3_DST_PATH}/$i/ttcn/${BN} ${VAGRANT_DIR}
	      fi
    done
    # XSD files
    LIST_TTCN_FILES=`find ${TTCN_3_ORG_PATH}/$i -name "*.xsd" -type f`
    for j in ${LIST_TTCN_FILES}
    do
	      BN=`basename $j`
	      s1=`sha256sum -b $j | cut -d' ' -f1`
	      s2=`sha256sum -b ${TTCN_3_DST_PATH}/$i/ttcn/${BN} | cut -d' ' -f1`
	      if [ "${s1}" != "${s2}" ]
	      then
	          cp ${TTCN_3_DST_PATH}/$i/xsd/${BN} ${VAGRANT_DIR}
	      fi
    done
    # Other files
    if [ -f ${SRC_EMCOM_PATH}/docs/$i/o2.cfg ]
    then
	      s1=`sha256sum -b ${PATH_DEV_EMCOM}/src/$i/docs/o2.cfg | cut -d' ' -f1`
	      s2=`sha256sum -b ${SRC_EMCOM_PATH}/docs/$i/o2.cfg | cut -d' ' -f1`
	      if [ "${s1}" != "${s2}" ]
	      then
            mkdir -p ${VAGRANT_DIR}/docs/$i
	          cp ${PATH_DEV_EMCOM}/src/$i/docs/o2.cfg ${VAGRANT_DIR}/docs/$i
	      fi
    fi
    if [ -f ${SRC_EMCOM_PATH}/etc/$i/$i.cfg ]
    then
	      s1=`sha256sum -b ${PATH_DEV_EMCOM}/src/$i/etc/$i.cfg | cut -d' ' -f1`
	      s2=`sha256sum -b ${SRC_EMCOM_PATH}/etc/$i/$i.cfg | cut -d' ' -f1`
	      if [ "${s1}" != "${s2}" ]
	      then
            mkdir -p ${VAGRANT_DIR}/etc/$i
	          cp ${PATH_DEV_EMCOM}/src/$i/etc/%i.cfg ${VAGRANT_DIR}/etc/$i
	      fi
    fi
done

TTCN_3_LIB_LIST='LibHttp LibPemea'
for i in ${TTCN_3_LIB_LIST}
do
    LIST_TTCN_FILES=`find ${TTCN_3_ORG_PATH}/$i -name "*.ttcn" -type f`
    for j in ${LIST_TTCN_FILES}
    do
	      BN=`basename $j`
	      s1=`sha256sum -b $j | cut -d' ' -f1`
	      s2=`sha256sum -b ${TTCN_3_DST_PATH}/$i/ttcn/${BN} | cut -d' ' -f1`
	      if [ "${s1}" != "${s2}" ]
	      then
	          cp ${TTCN_3_DST_PATH}/$i/ttcn/${BN} ${VAGRANT_DIR}
	          rm ${TTCN_3_DST_PATH}/$i/ttcn/${BN}~
	      fi
    done
done


LIST_FILES=`find ${PATH_DEV_EMCOM} -name "*~" -type f`
for i in ${LIST_FILES}
do
    BN=$i
    BN=${BN:: -1} # Remove the last character
    cp ${BN} ${VAGRANT_DIR}
    rm $i
done

chmod -R 664 ${VAGRANT_DIR}
exit 0

