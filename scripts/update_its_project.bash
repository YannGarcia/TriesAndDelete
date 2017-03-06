#!/bin/bash
# Usage: sudo ./update_project.bash
#asn1_compiler -b -d -f -g -l -L -w -t -R -U none -x -X -j ../../asn1/LibIts/ITS-Container/ITS_Container.asn ../../asn1/LibIts/CAM/CAM.asn ../../asn1/LibIts/DENM/DENM.asn ../src/*.ttcn > build.log 2>&1 3>&1




echo 'Update ASN.1 files'
ASN1_ORG_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF517_ITS_Valid_Conform_Frmwk.2016/workspace_tct3/STF517_ITS_Valid_Conform_Frmwk.2016/asn1/LibIts
ASN1_DEST_PATH=/home/yann/dev/ttcn3/its-cms5/asn1/LibIts
ASN1_LIST='CAM DENM ITS-Container'
for i in ${ASN1_LIST}
do
    if [ ! -d ${ASN1_DEST_PATH}/$i ]
    then
	mkdir ${ASN1_DEST_PATH}/$i
	chmod 775 ${ASN1_DEST_PATH}/$i
    fi
    cp ${ASN1_ORG_PATH}/$i/*.asn ${ASN1_DEST_PATH}/$i
    chmod 664 ${ASN1_DEST_PATH}/*.asn
    chown -R yann:yann ${ASN1_DEST_PATH}/$i
done
#IS_ORG_FILES='ETSI_TS_103301_IVIM_PDU_Descriptions.asn ETSI_TS_103301_MAPEM_PDU_Descriptions.asn ETSI_TS_103301_SPATEM_PDU_Descriptions.asn ETSI_TS_103301_SREM_PDU_Descriptions.asn ETSI_TS_103301_SSEM_PDU_Descriptions.asn ISO_TS_14816.asn ISO_TS_14906_Application.asn ISO_TS_14906_Generic.asn ISO_TS_17419.asn ISO_TS_19091_AddGrpC.asn ISO_TS_19091_DSRC.asn ISO_TS_19091_REGION.asn ISO_TS_19321.asn ISO_TS_24534-3.asn'
#IS_ORG_FILES='ITS_Container.asn CAM.asn DENM.asn    ETSI_TS_103301_IVIM_PDU_Descriptions.asn ETSI_TS_103301_MAPEM_PDU_Descriptions.asn ETSI_TS_103301_SPATEM_PDU_Descriptions.asn ETSI_TS_103301_SREM_PDU_Descriptions.asn ETSI_TS_103301_SSEM_PDU_Descriptions.asn ISO_TS_14816.asn ISO_TS_14906_Application.asn ISO_TS_14906_Generic.asn ISO_TS_17419.asn ISO_TS_19091_AddGrpC.asn ISO_TS_19091_DSRC.asn ISO_TS_19091_REGION.asn ISO_TS_19321.asn ISO_TS_24534-3.asn'

#IS_DEST_FILES[0]='ETSI_TS_103301_IVIM_PDU_Descriptions.asn'
#IS_DEST_FILES[1]='ETSI_TS_103301_MAPEM_PDU_Descriptions.asn'
#ETSI_TS_103301_SPATEM_PDU_Descriptions.asn ETSI_TS_103301_SREM_PDU_Descriptions.asn ETSI_TS_103301_SSEM_PDU_Descriptions.asn ISO_TS_14816.asn ISO_TS_14906_Application.asn ISO_TS_14906_Generic.asn ISO_TS_17419.asn ISO_TS_19091_AddGrpC.asn ISO_TS_19091_DSRC.asn ISO_TS_19091_REGION.asn ISO_TS_19321.asn ISO_TS_24534-3.asn'







echo 'Update TTCN-3 files'
TTCN_3_ORG_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF517_ITS_Valid_Conform_Frmwk.2016/workspace_ttwb/STF517/ttcn
TTCN_3_DEST_PATH=/home/yann/dev/ttcn3/its-cms5
TTCN_3_ATS_LIST='AtsCAM AtsDENM AtsIVIM AtsRSUsSimulator AtsSremSsem AtsBTP AtsGeoNetworking AtsMapemSpatem AtsSecurity LibCommon'
for i in '${TTCN_3_ATS_LIST}'
do
    if [ ! -d ${TTCN_3_DEST_PATH}/$i ]
    then
	mkdir -p ${TTCN_3_DEST_PATH}/$i/src
	chmod -R 775 ${TTCN_3_DEST_PATH}/$i
    fi
    cp ${TTCN_3_ORG_PATH}/$i/*.ttcn ${TTCN_3_DEST_PATH}/$i/src
    chmod 664 ${ASN1_DEST_PATH}/$i/src/*.ttcn
    chown -R yann:yann ${TTCN_3_DEST_PATH}/$i
done
TTCN_3_LIB_LIST='Common CAM DENM IVIM SremSsem BTP GeoNetworking Ipv6OverGeoNetworking MapemSpatem Security'
for i in '${TTCN_3_LIB_LIST}'
do
    if [ ! -d ${TTCN_3_DEST_PATH}/LibIts/$i ]
    then
	mkdir -p ${TTCN_3_DEST_PATH}/LibIts/$i/src
	chmod -R 775 ${TTCN_3_DEST_PATH}/LibIts/$i
    fi
    cp ${TTCN_3_ORG_PATH}/LibIts/$i/*.ttcn ${TTCN_3_DEST_PATH}/LibIts/$i/src
    chmod 664 ${ASN1_DEST_PATH}/LibIts/$i/src/*.ttcn
    chown -R yann:yann ${TTCN_3_DEST_PATH}/LibIts/$i
done
