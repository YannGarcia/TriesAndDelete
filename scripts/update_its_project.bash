#!/bin/bash

# Debug mode
set -x

# Usage: sudo ./update_project.bash
SRC_ITS_PATH=/cygdrive/f/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
DST_ITS_PATH=${PATH_DEV_ITS}
CHOWN_USER_GROUP=yann:None

# Check if target directory exist
if [ ! -d ${PATH_DEV_ITS} ]
then
    mkdir -p ${PATH_DEV_ITS}/asn1/LibIts ${PATH_DEV_ITS}/ttcn ${PATH_DEV_ITS}/include ${PATH_DEV_ITS}/src ${PATH_DEV_ITS}/objs ${PATH_DEV_ITS}/docs
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
    cp ${ASN1_SRC_PATH}/$i/*.asn ${ASN1_DST_PATH}/$i
    chmod 664 ${ASN1_DST_PATH}/$i/*.asn
    chown -R ${CHOWN_USER_GROUP} ${ASN1_DST_PATH}/$i
done


# Update TTCN-3 files
echo 'Update TTCN-3 files'
TTCN_3_ORG_PATH=${SRC_ITS_PATH}/ttcn
TTCN_3_DST_PATH=${PATH_DEV_ITS}/ttcn
TTCN_3_ATS_LIST='AtsAutoInterop AtsCAM AtsDENM AtsGeoNetworking AtsSecurity LibCommon'
for i in ${TTCN_3_ATS_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/$i ]
    then
	mkdir -p ${TTCN_3_DST_PATH}/$i
	chmod -R 775 ${TTCN_3_DST_PATH}/$i
    fi
    cp ${TTCN_3_ORG_PATH}/$i/*.ttcn ${TTCN_3_DST_PATH}/$i
    chmod 664 ${TTCN_3_DST_PATH}/$i/*.ttcn
    chown -R ${CHOWN_USER_GROUP} ${TTCN_3_DST_PATH}/$i
done

TTCN_3_LIB_LIST='Common CAM DENM BTP GeoNetworking Ipv6OverGeoNetworking Security'
for i in ${TTCN_3_LIB_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/LibIts/$i ]
    then
	mkdir -p ${TTCN_3_DST_PATH}/LibIts/$i
	chmod -R 775 ${TTCN_3_DST_PATH}/LibIts/$i
    fi
    cp ${TTCN_3_ORG_PATH}/LibIts/$i/*.ttcn ${TTCN_3_DST_PATH}/LibIts/$i
    chmod 664 ${TTCN_3_DST_PATH}/LibIts/$i/*.ttcn
    chown -R ${CHOWN_USER_GROUP} ${TTCN_3_DST_PATH}/LibIts/$i
done

