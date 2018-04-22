#!/bin/bash

# Debug mode
#set -evx

# Usage: sudo ./merge_ite_project.bash
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
then
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
elif [ "${UNAME}" == "ubuntu-xenial" ] || [ "${UNAME}" == "vagrant" ]
then
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
elif [ "${UNAME}" == "vagrant-prov" ]
then
    SRC_ITS_PATH=~/tmp/STF525
else # Cygwin
    SRC_ITS_PATH=/cygdrive/f/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
fi
if [ "${PATH_DEV_ITS}" == "" ]
then
    PATH_DEV_ITS=`pwd`/../etsi_its
fi

# Update ETSI Framework files
echo 'Merging ETSI Framework files'
FWK_SRC_PATH=${SRC_ITS_PATH}/ccsrc
FWK_DST_PATH=${PATH_DEV_ITS}/framework
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Protocols/ -name "*.h*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
    BN=`basename $i`
    if [ "${BN}" != "BTPPort.hh" ]
    then
	      s1=`sha256sum -b $i | cut -d' ' -f1`
	      s2=`sha256sum -b ${FWK_DST_PATH}/include/${BN} | cut -d' ' -f1`
	      if [ ${s1} != ${s2} ]
	      then
	          cp ${FWK_DST_PATH}/include/${BN} ${VAGRANT_DIR}
	          if [ -f ${FWK_DST_PATH}/include/${BN}~ ]
	          then
		            rm ${FWK_DST_PATH}/include/${BN}~
	          fi
	      fi
    fi
done
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Protocols/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_CC}
do
    BN=`basename $i`
    if [ ${BN} != BTPPort.cc ]
    then	
	      s1=`sha256sum -b $i | cut -d' ' -f1`
	      s2=`sha256sum -b ${FWK_DST_PATH}/src/${BN} | cut -d' ' -f1`
	      if [ ${s1} != ${s2} ]
	      then
	          cp ${FWK_DST_PATH}/src/${BN} ${VAGRANT_DIR}
	          if [ -f ${FWK_DST_PATH}/src/${BN}~ ]
	          then
		            rm ${FWK_DST_PATH}/src/${BN}~
	          fi
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
    if [ ${s1} != ${s2} ]
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
    if [ ${s1} != ${s2} ]
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
    if [ ${s1} != ${s2} ]
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
    if [ ${s1} != ${s2} ]
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
TTCN_3_ORG_PATH=${SRC_ITS_PATH}/ttcn
TTCN_3_DST_PATH=${PATH_DEV_ITS}/src
TTCN_3_ATS_LIST='AtsAutoInterop AtsCAM AtsDENM AtsBTP AtsGeoNetworking AtsSecurity LibCommon TestCodec'
for i in ${TTCN_3_ATS_LIST}
do
    LIST_TTCN_FILES=`find ${TTCN_3_ORG_PATH}/$i -name "*.ttcn" -type f`
    for j in ${LIST_TTCN_FILES}
    do
	      BN=`basename $j`
	      s1=`sha256sum -b $j | cut -d' ' -f1`
	      s2=`sha256sum -b ${TTCN_3_DST_PATH}/$i/ttcn/${BN} | cut -d' ' -f1`
	      if [ ${s1} != ${s2} ]
	      then
	          cp ${TTCN_3_DST_PATH}/$i/ttcn/${BN} ${VAGRANT_DIR}
	      fi
    done
    # Other files
    if [ -f ${SRC_ITS_PATH}/docs/$i/o2.cfg ]
    then
	      s1=`sha256sum -b ${PATH_DEV_ITS}/src/$i/docs/o2.cfg | cut -d' ' -f1`
	      s2=`sha256sum -b ${SRC_ITS_PATH}/docs/$i/o2.cfg | cut -d' ' -f1`
	      if [ ${s1} != ${s2} ]
	      then
            mkdir -p ${VAGRANT_DIR}/docs/$i
	          cp ${PATH_DEV_ITS}/src/$i/docs/o2.cfg ${VAGRANT_DIR}/docs/$i
	      fi
    fi
    if [ -f ${SRC_ITS_PATH}/etc/$i/ITSTS.cfg ]
    then
	      s1=`sha256sum -b ${PATH_DEV_ITS}/src/$i/etc/ITSTS.cfg | cut -d' ' -f1`
	      s2=`sha256sum -b ${SRC_ITS_PATH}/etc/$i/ITSTS.cfg | cut -d' ' -f1`
	      if [ ${s1} != ${s2} ]
	      then
            mkdir -p ${VAGRANT_DIR}/etc/$i
	          cp ${PATH_DEV_ITS}/src/$i/etc/ITSTS.cfg ${VAGRANT_DIR}/etc/$i
	      fi
    fi
done

TTCN_3_LIB_LIST='Common BTP CAM DENM GeoNetworking Ipv6OverGeoNetworking Security'
for i in ${TTCN_3_LIB_LIST}
do
    LIST_TTCN_FILES=`find ${TTCN_3_ORG_PATH}/LibIts/$i -name "*.ttcn" -type f`
    for j in ${LIST_TTCN_FILES}
    do
	      BN=`basename $j`
	      s1=`sha256sum -b $j | cut -d' ' -f1`
	      s2=`sha256sum -b ${TTCN_3_DST_PATH}/LibIts/$i/ttcn/${BN} | cut -d' ' -f1`
	      if [ ${s1} != ${s2} ]
	      then
	          cp ${TTCN_3_DST_PATH}/LibIts/$i/ttcn/${BN} ${VAGRANT_DIR}
	          rm ${TTCN_3_DST_PATH}/LibIts/$i/ttcn/${BN}~
	      fi
    done
    #    FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/src/LibIts/$i/include -name "*.h*" -type f`
    #    FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/src/LibIts/$i/src -name "*.c*" -type f`
    #    for j in ${FWK_DIR_LIST_HH}
    #    do
    #	BN=`basename $j`
    #	s1=`sha256sum -b $j | cut -d' ' -f1`
    #	s2=`sha256sum -b ${PATH_DEV_ITS}/src/LibIts/$i/include/${BN} | cut -d' ' -f1`
    #	if [ ${s1} != ${s2} ]
    #	then
    #	    cp ${PATH_DEV_ITS}/src/LibIts/$i/include/${BN} ${VAGRANT_DIR}
    #	    rm ${PATH_DEV_ITS}/src/LibIts/$i/include/${BN}~
    #	fi
    #   done
    #    for j in ${FWK_DIR_LIST_CC}
    #    do
    #	BN=`basename $j`
    #	s1=`sha256sum -b $j | cut -d' ' -f1`
    #	s2=`sha256sum -b ${PATH_DEV_ITS}/src/LibIts/$i/src/${BN} | cut -d' ' -f1`
    #	if [ ${s1} != ${s2} ]
    #	then
    #	    cp ${PATH_DEV_ITS}/src/LibIts/$i/src/${BN} ${VAGRANT_DIR}
    #	    rm ${PATH_DEV_ITS}/src/LibIts/$i/src/${BN}~
    #	fi
    #   done
done


LIST_FILES=`find ${PATH_DEV_ITS} -name "*~" -type f`
for i in ${LIST_FILES}
do
    BN=$i
    BN=${BN:: -1} # Remove the last character
    cp ${BN} ${VAGRANT_DIR}
    rm $i
done

chmod -R 664 ${VAGRANT_DIR}
exit 0

