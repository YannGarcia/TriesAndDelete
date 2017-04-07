#!/bin/bash

# Debug mode
set -evx

# Usage: sudo ./update_project.bash
# TODO Use git clone in temporary directory
UNAME=`uname -n`
if [ "${UNAME}" == "Ubuntu64" ]
then
    CHOWN_USER_GROUP=yann:yann
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
else 
    CHOWN_USER_GROUP=yann:None
    SRC_ITS_PATH=/cygdrive/f/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
fi
if [ "${PATH_DEV_ITS}" == "" ]
then
    PATH_DEV_ITS=`pwd`/../etsi_its
fi

# Check if target directory exist
if [ ! -d ${PATH_DEV_ITS} ]
then
    mkdir -p ${PATH_DEV_ITS}/asn1/LibIts ${PATH_DEV_ITS}/include ${PATH_DEV_ITS}/bin ${PATH_DEV_ITS}/objs ${PATH_DEV_ITS}/src ${PATH_DEV_ITS}/docs
fi

# Update ASN.1 files
echo 'Updating ASN.1 files'
ASN1_SRC_PATH=${SRC_ITS_PATH}/asn1/LibIts
ASN1_DST_PATH=${PATH_DEV_ITS}/asn1/LibIts
ASN1_DIR_LIST=`find ${ASN1_SRC_PATH} -type d -not -path "*/.svn*" | cut -sd / -f13-`
for i in ${ASN1_DIR_LIST}
do
    if [ ! -d ${ASN1_DST_PATH}/$i ]
    then
	mkdir ${ASN1_DST_PATH}/$i
	chmod 775 ${ASN1_DST_PATH}/$i
    fi
    for j in `ls ${ASN1_SRC_PATH}/$i/*.asn`
    do
	cp $j ${ASN1_DST_PATH}/$i
    done
done

# Update ATS TTCN-3 files
echo 'Update TTCN-3 files'
TTCN_3_ORG_PATH=${SRC_ITS_PATH}/ttcn
TTCN_3_DST_PATH=${PATH_DEV_ITS}/src
TTCN_3_ATS_LIST='AtsAutoInterop AtsCAM AtsDENM AtsGeoNetworking AtsSecurity LibCommon'
for i in ${TTCN_3_ATS_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/$i ]
    then
	mkdir -p ${TTCN_3_DST_PATH}/$i/bin ${TTCN_3_DST_PATH}/$i/lib ${TTCN_3_DST_PATH}/$i/include ${TTCN_3_DST_PATH}/$i/ttcn ${TTCN_3_DST_PATH}/$i/objs ${TTCN_3_DST_PATH}/$i/cfg ${TTCN_3_DST_PATH}/$i/docs
	chmod -R 775 ${TTCN_3_DST_PATH}/$i
    fi
    cp ${TTCN_3_ORG_PATH}/$i/*.ttcn ${TTCN_3_DST_PATH}/$i/ttcn
done

# Update libraries & CC files
CC_SRC_PATH=${SRC_ITS_PATH}/ccsrc
TTCN_3_LIB_LIST='Common BTP CAM DENM GeoNetworking Ipv6OverGeoNetworking Security'
for i in ${TTCN_3_LIB_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/LibIts/$i ]
    then
	mkdir -p ${TTCN_3_DST_PATH}/LibIts/$i/bin ${TTCN_3_DST_PATH}/LibIts/$i/docs ${TTCN_3_DST_PATH}/LibIts/$i/lib ${TTCN_3_DST_PATH}/LibIts/$i/src ${TTCN_3_DST_PATH}/LibIts/$i/include ${TTCN_3_DST_PATH}/LibIts/$i/ttcn ${TTCN_3_DST_PATH}/$i/objs
    fi
    cp ${TTCN_3_ORG_PATH}/LibIts/$i/*.ttcn ${TTCN_3_DST_PATH}/LibIts/$i/ttcn
    # Update CC files
    if [ "$i" == "Common" ]
    then
	cp ${CC_SRC_PATH}/Externals/LibItsCommon_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "BTP" ]
    then
	cp ${CC_SRC_PATH}/EncDec/LibItsBtp_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/BTP_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/BTP_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/BTP_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "CAM" ]
    then
	cp ${CC_SRC_PATH}/EncDec/LibItsCam_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/CAM_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/CAM_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/CAM_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "DENM" ]
    then
	cp ${CC_SRC_PATH}/EncDec/LibItsDenm_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/DENM_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/DENM_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/DENM_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "GeoNetworking" ]
    then
	cp ${CC_SRC_PATH}/EncDec/LibItsGeoNetworking_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Externals/LibItsGeoNetworking_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/GN_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/GN_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/GN_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "Ipv6OverGeoNetworking" ]
    then
	cp ${CC_SRC_PATH}/Externals/LibItsIpv6OverGeoNetworking_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/IPv6oGN_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "Security" ]
    then
	cp ${CC_SRC_PATH}/EncDec/LibItsSecurity_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Externals/LibItsSecurity_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
    fi
done

# Apply patches
PATH_PATCHES=`pwd`/etsi_its_patches
if [ -d ${PATH_PATCHES} ]
then
    cp ${PATH_PATCHES}/LibCommon_build.bash ${TTCN_3_DST_PATH}/LibCommon/bin
    cp ${PATH_PATCHES}/LibItsCommon_build.bash ${TTCN_3_DST_PATH}/LibIts/Common/bin
fi

# Set rights
find ${PATH_DEV_ITS} -type f -exec chmod 664 {} \;
find ${PATH_DEV_ITS} -name "*.bash" -type f -exec chmod 775 {} \;
find ${PATH_DEV_ITS} -type d -exec chmod 775 {} \;
chown -R ${CHOWN_USER_GROUP} ${PATH_DEV_ITS}
