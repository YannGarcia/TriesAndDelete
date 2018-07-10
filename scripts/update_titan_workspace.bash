#!/bin/bash
set -xv
#set -e

TITAN_PATH=${HOME}/tmp/workspace_titan
if [ ! -d /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop ]
then
    if [ -! -d $HOME/tmp/STF525 ]
    then
        exit -1
    else
        ORG_PATH=$HOME/tmp/STF525
    fi
else
    ORG_PATH=/media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop
fi
if [ "$ORG_PATH" == "" ]
then
    exit -1
fi
if [ ! -d ${TITAN_PATH}/STF525_Auto_Interop/src ]
then
    mkdir -p ${TITAN_PATH}/STF525_Auto_Interop/src
fi
cd ${TITAN_PATH}/STF525_Auto_Interop/src

# Cleanup bin folders
if [ -d ./bin ]
then
    rm -fr ./bin
fi
if [ -d ../ccsrc ]
then
    rm -fr ../ccsrc
fi
if [ -d ../ttcn ]
then
    rm -fr ../ttcn
fi
if [ -d ../testdata ]
then
    rm -fr ../testdata
fi
find . -name ".o" -type f -exec rm {} \;

# Copy configuration files
cp -Rp ${ORG_PATH}/etc .
# Copy testdata files
cp -Rp ${ORG_PATH}/testdata .
# Copy source files
cp -Rp ${ORG_PATH}/ccsrc/ .
# Create link to TITAN Abstract_Socket
ln -sf $TOP/../titan.TestPorts.Common_Components.Abstract_Socket/src/Abstract_Socket.cc ./ccsrc/Protocols/Tcp/Abstract_Socket.cc
ln -sf $TOP/../titan.TestPorts.Common_Components.Abstract_Socket/src/Abstract_Socket.hh ./ccsrc/Protocols/Tcp/Abstract_Socket.hh
# Copy TTCN-3 files
cp -Rp ${ORG_PATH}/ttcn/ .
cp -Rp ${ORG_PATH}/asn1/ .
# Copy Eclipse TPD file
cp -Rp ${ORG_PATH}/STF525_Auto_Interop.tpd .
# Remove origine ASN.1 file for IS/ISO-TS-19091
if [ -d ./asn1/LibIts/IS/ISO_TS_19091/original ]
then
    rm -fr ./asn1/LibIts/IS/ISO_TS_19091/original
fi

# Update generated ASN.1 header files
mkdir -p ./bin/asn1
cp ${HOME}/TriesAndDelete/etsi_its/bin/asn1/*.h ./bin/asn1

find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;

sudo find . -name ".svn" -type d -exec rm -fr {} \;

cd -

exit 0
