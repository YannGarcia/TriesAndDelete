#!/bin/bash

# Debug mode
#set -e
set -vx

# Usage: sudo ./update_project.bash
# TODO Use git clone in temporary directory

OLDPWD=`pwd`

# Execution path
RUN_PATH="${0%/*}"

UNAME=`uname -n`
if [ "${UNAME}" == "Ubuntu64" ]
then # Win7 Virtualbox Ubuntu 16.04
    CHOWN_USER_GROUP=yann:yann
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
elif [ "${UNAME}" == "ubuntu-xenial" ]
then # Vqgrant xenial-ubuntu
    CHOWN_USER_GROUP=ubuntu:ubuntu
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
elif [ "${UNAME}" == "vagrant" ]
then # Vagrant xenial-ubuntu
    CHOWN_USER_GROUP=vagrant:vagrant
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
elif [ "${UNAME}" == "vagrant-prov" ]
then # Vagrant ubuntu 16.04 with provisioner script to automate ITS project build & test
    CHOWN_USER_GROUP=ubuntu:ubuntu
    SRC_ITS_PATH=${HOME}/tmp/STF525
elif [ "${UNAME}" == "yann-FSCOM" ]
then # Win7 cygwin64
    CHOWN_USER_GROUP=yann:None
    SRC_ITS_PATH=/cygdrive/f/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
else # docket-titan
    CHOWN_USER_GROUP=root:root
    SRC_ITS_PATH=${HOME}/tmp/STF525
fi
if [ "${PATH_DEV_ITS}" == "" ]
then
    PATH_DEV_ITS=`pwd`/../etsi_its
fi

if [ -d ${PATH_DEV_ITS} ]
then
    if [ -f ${HOME}/tmp/etsi_its.tar.bz2 ]
    then
	      rm ${HOME}/tmp/etsi_its.tar.bz2
    fi
    tar jcvf ${HOME}/tmp/etsi_its.tar.bz2 ${PATH_DEV_ITS}
    rm -fr ${PATH_DEV_ITS}
fi

# Check if target directory exist
if [ ! -d ${PATH_DEV_ITS} ]
then
    mkdir -p ${PATH_DEV_ITS}/asn1/LibIts ${PATH_DEV_ITS}/include ${PATH_DEV_ITS}/bin ${PATH_DEV_ITS}/lib ${PATH_DEV_ITS}/objs ${PATH_DEV_ITS}/src ${PATH_DEV_ITS}/docs
fi

# Update ASN.1 files
echo 'Updating ASN.1 files'
ASN1_SRC_PATH=${SRC_ITS_PATH}/asn1/LibIts
ASN1_DST_PATH=${PATH_DEV_ITS}/asn1/LibIts
NB_DEL=`echo ${ASN1_SRC_PATH} | awk -F"/" '{print NF + 1}'`
ASN1_DIR_LIST=`find ${ASN1_SRC_PATH} -type d -not -path "*/.svn*" | cut -sd / -f${NB_DEL}-`
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
cp ${ASN1_SRC_PATH}/../Makefile ${ASN1_DST_PATH}/..

# Update testdata
echo 'Updating testdata'
FWK_SRC_PATH=${SRC_ITS_PATH}/testdata
FWK_DST_PATH=${PATH_DEV_ITS}
if [ -d ${FWK_SRC_PATH} ]
then
    cp -Rp ${FWK_SRC_PATH} ${FWK_DST_PATH}
fi

# Update ETSI Framework files
echo 'Updating ETSI Framework files'
FWK_SRC_PATH=${SRC_ITS_PATH}/ccsrc
FWK_DST_PATH=${PATH_DEV_ITS}/framework
mkdir -p ${FWK_DST_PATH}/src ${FWK_DST_PATH}/include
chmod -R 775 ${FWK_DST_PATH}
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Protocols/ -name "*.h*" -type f`
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Protocols/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
    if [ `basename $i` != BTPPort.hh ]
    then
	      cp $i ${FWK_DST_PATH}/include
    fi
done
for i in ${FWK_DIR_LIST_CC}
do
    if [ `basename $i` != BTPPort.cc ]
    then
	      cp $i ${FWK_DST_PATH}/src
    fi
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
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/loggers/ -name "*.h*" -type f`
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/loggers/ -name "*.c*" -type f`
for i in ${FWK_DIR_LIST_HH}
do
    cp $i ${FWK_DST_PATH}/include
done
for i in ${FWK_DIR_LIST_CC}
do
    cp $i ${FWK_DST_PATH}/src
done
FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/Asn1c/ -name "*.h*" -type f`
FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/Asn1c/ -name "*.c*" -type f`
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
TTCN_3_ORG_PATH=${SRC_ITS_PATH}/ttcn
TTCN_3_DST_PATH=${PATH_DEV_ITS}/src
CC_SRC_PATH=${SRC_ITS_PATH}/ccsrc
TTCN_3_ATS_LIST='AtsAutoInterop AtsCAM AtsDENM AtsBTP AtsGeoNetworking AtsSecurity AtsRSUsSimulator LibCommon TestCodec'
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
    if [ "$i" == "AtsRSUsSimulator" ]
    then
        # Arg should create a LibItsRSUsSimulator and move it in Update libraries & CC files
	      cp ${CC_SRC_PATH}/Externals/AtsRSUsSimulator_externals.cc ${TTCN_3_DST_PATH}/$i/src # 
    fi
done

# Update libraries & CC files
TTCN_3_LIB_LIST='Common BTP CAM DENM GeoNetworking Ipv6OverGeoNetworking Security MapemSpatem IVIM SremSsem'
for i in ${TTCN_3_LIB_LIST}
do
    if [ ! -d ${TTCN_3_DST_PATH}/LibIts/$i ]
    then
	      mkdir -p ${TTCN_3_DST_PATH}/LibIts/$i/docs ${TTCN_3_DST_PATH}/LibIts/$i/src ${TTCN_3_DST_PATH}/LibIts/$i/include ${TTCN_3_DST_PATH}/LibIts/$i/ttcn
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
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/BTP_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/BTP_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/BTP_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "CAM" ]
    then
	      cp ${CC_SRC_PATH}/EncDec/LibItsCam_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/CAM_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/CAM_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/CAM_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/CAM_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "DENM" ]
    then
	      cp ${CC_SRC_PATH}/EncDec/LibItsDenm_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/DENM_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/DENM_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/DENM_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/DENM_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "GeoNetworking" ]
    then
	      cp ${CC_SRC_PATH}/EncDec/LibItsGeoNetworking_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Externals/LibItsGeoNetworking_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/GN_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/GN_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/GN_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/GN_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "Ipv6OverGeoNetworking" ]
    then
	      cp ${CC_SRC_PATH}/EncDec/LibItsIpv6OverGeoNetworking_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Externals/LibItsIpv6OverGeoNetworking_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/IPv6oGN_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/IPv6oGN_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "Security" ]
    then
	      cp ${CC_SRC_PATH}/EncDec/LibItsSecurity_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Externals/LibItsSecurity_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
    elif [ "$i" == "MapemSpatem" ]
    then
	      #cp ${CC_SRC_PATH}/EncDec/LibItsCam_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/MapemSpatem_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/MapemSpatem_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/MapemSpatem_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/MapemSpatem_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "IVIM" ]
    then
	      cp ${CC_SRC_PATH}/EncDec/LibItsIvim_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/IVIM_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/IVIM_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/IVIM_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/IVIM_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    elif [ "$i" == "SremSsem" ]
    then
	      #cp ${CC_SRC_PATH}/EncDec/LibItsCam_Encdec.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/SremSsem_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/SremSsem_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/SremSsem_ports/*.partC ${TTCN_3_DST_PATH}/LibIts/$i/src
	      cp ${CC_SRC_PATH}/Ports/LibIts_ports/SremSsem_ports/*.partH ${TTCN_3_DST_PATH}/LibIts/$i/include
    fi
done

# Apply patches
PATH_PATCHES=`pwd`/etsi_its_patches
if [ -d ${PATH_PATCHES} ]
then
    # Patch ASN1C Makefile
    # Update GeoNetworking
    cp ${PATH_PATCHES}/geonw_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsGeoNetworking/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_ITS}/src/AtsGeoNetworking/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_ITS}/src/AtsGeoNetworking/bin
    # Update BTP
    cp ${PATH_PATCHES}/btp_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsBTP/bin
    ${RUN_PATH}/etsi_its_patches/asn1c_patch.bash ${ASN1_DST_PATH}/../Makefile
    # Update CAM
    cp ${PATH_PATCHES}/cam_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsCAM/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_ITS}/src/AtsCAM/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_ITS}/src/AtsCAM/bin
    # Update DENM
    cp ${PATH_PATCHES}/denm_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsDENM/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_ITS}/src/AtsDENM/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_ITS}/src/AtsDENM/bin
    # Update RSUsSimulator
    cp ${PATH_PATCHES}/rsusimulator_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsRSUsSimulator/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_ITS}/src/AtsRSUsSimulator/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_ITS}/src/AtsRSUsSimulator/bin
    # Update AutoInterop
	  cp ${CC_SRC_PATH}/Ports/LibIts_ports/AutoInterop_ports/*.cc ${TTCN_3_DST_PATH}/AtsAutoInterop/src
	  cp ${CC_SRC_PATH}/Ports/LibIts_ports/AutoInterop_ports/*.hh ${TTCN_3_DST_PATH}/AtsAutoInterop/include
    cp ${PATH_PATCHES}/autointerop_generate_makefile.bash  ${PATH_DEV_ITS}/src/AtsAutoInterop/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_ITS}/src/AtsAutoInterop/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_ITS}/src/AtsAutoInterop/bin
    # Update TestCodec
    cp ${PATH_PATCHES}/testcodec_generate_makefile.bash ${PATH_DEV_ITS}/src/TestCodec/bin
    cp ${PATH_PATCHES}/../run_mtc.bash ${PATH_DEV_ITS}/src/TestCodec/bin
    cp ${PATH_PATCHES}/../run_ptcs.bash ${PATH_DEV_ITS}/src/TestCodec/bin
fi

# Set rights
find ${PATH_DEV_ITS} -type f -exec chmod 664 {} \;
find ${PATH_DEV_ITS} -name "*.bash" -type f -exec chmod 775 {} \;
find ${PATH_DEV_ITS} -type d -exec chmod 775 {} \;
chown -R ${CHOWN_USER_GROUP} ${PATH_DEV_ITS}

# Build libAsn1
cd ${ASN1_DST_PATH}/..
make CC=gcc
rm -fr ${PATH_DEV_ITS}/asn1/LibIts/IS/ISO_TS_19091/original
cd -
if [ ! -d ${PATH_DEV_ITS}/include/asn1 ]
then
    mkdir ${PATH_DEV_ITS}/include/asn1
else
    for i in `find ${PATH_DEV_ITS}/include/asn1 -name "*.h"`;
    do
	      rm $i
    done
fi
for i in `find ${PATH_DEV_ITS}/bin/asn1 -name "*.h"`
do
    cp $i ${PATH_DEV_ITS}/include/asn1
done
ln -sf ${PATH_DEV_ITS}/bin/asn1/libItsAsn.so ${PATH_DEV_ITS}/lib/libItsAsn.so
#cp ${HOME}/frameworks/asn1c/skeletons/ANY.h ${PATH_DEV_ITS}/include/asn1
cd ${OLDPWD}

exit 0

