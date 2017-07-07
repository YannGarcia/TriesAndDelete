#!/bin/bash

# Debug mode
set -evx

# Usage: sudo ./update_project.bash
# TODO Use git clone in temporary directory

OLDPWD=`pwd`

# Execution path
RUN_PATH="${0%/*}"
UNAME=`uname -n`
if [ "${UNAME}" == "Ubuntu64" ]
then
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
elif [ "${UNAME}" == "ubuntu-xenial" ]
then
    SRC_ITS_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src
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
else 
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
TTCN_3_ATS_LIST='AtsAutoInterop AtsCAM AtsDENM AtsBtp AtsGeoNetworking AtsSecurity LibCommon TestCodec'
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
done

TTCN_3_LIB_LIST='Common BTP CAM DENM GeoNetworking Ipv6OverGeoNetworking Security'
for i in ${TTCN_3_LIB_LIST}
do
    LIST_TTCN_FILES=`find ${TTCN_3_ORG_PATH}/LibIts/$i -name "*.ttcn" -type f`
    FWK_DIR_LIST_HH=`find ${FWK_SRC_PATH}/src/LibIts/$i/include -name "*.h*" -type f`
    FWK_DIR_LIST_CC=`find ${FWK_SRC_PATH}/src/LibIts/$i/src -name "*.c*" -type f`
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
for i in ${TTCN_3_LIB_LIST}
do
    BN=$i
    BN=${BN:: -1} # Remove the last character
    echo cp ${BN} ${VAGRANT_DIR}
done




exit 0





# Update libraries & CC files
CC_SRC_PATH=${SRC_ITS_PATH}/ccsrc
TTCN_3_LIB_LIST='Common BTP CAM DENM GeoNetworking Ipv6OverGeoNetworking Security'
for i in ${TTCN_3_LIB_LIST}
do
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
	cp ${CC_SRC_PATH}/Externals/LibItsIpv6OverGeoNetworking_externals.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/IPv6oGN_ports/*.cc ${TTCN_3_DST_PATH}/LibIts/$i/src
	cp ${CC_SRC_PATH}/Ports/LibIts_ports/IPv6oGN_ports/*.hh ${TTCN_3_DST_PATH}/LibIts/$i/include
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
    # Patch ASN1C Makefile
    # Update BTP
    cp ${PATH_PATCHES}/btp_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsBtp/bin
    ${RUN_PATH}/etsi_its_patches/asn1c_patch.bash ${ASN1_DST_PATH}/../Makefile
    # Update CAM
    cp ${PATH_PATCHES}/cam_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsCAM/bin
    # Update DENM
    cp ${PATH_PATCHES}/denm_generate_makefile.bash ${PATH_DEV_ITS}/src/AtsDENM/bin
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
#rm -fr ${PATH_DEV_ITS}/bin/asn1
#cp ~/frameworks/asn1c/skeletons/ANY.h ${PATH_DEV_ITS}/include/asn1
cd ${OLDPWD}

exit 0

