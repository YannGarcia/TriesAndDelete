#!/bin/bash
#set -xv

if [ ! -d /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop ]
then
    exit -1
fi
cd ~/tmp/workspace_titan/STF525_Auto_Interop/src

# Cleanup bin folders
if [ -d ./bin ]
then
    rm -fr ./bin
fi
if [ -d ../bin ]
then
    rm -fr ../bin
fi
find . -name ".o" -type f -exec rm {} \;

# Copy configuration files
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/etc .
# Copy testdata files
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/testdata .
# Copy source files
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/ccsrc/ .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/ttcn/ .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/asn1/ .
# Remove origine ASN.1 file for IS/ISO-TS-19091
if [ -d ./asn1/LibIts/IS/ISO_TS_19091/original ]
then
    rm -fr ./asn1/LibIts/IS/ISO_TS_19091/original
fi

# Update generated ASN.1 header files
mkdir -p ./bin/asn1
cp ~/TriesAndDelete/etsi_its/bin/asn1/*.h ./bin/asn1

find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;

sudo find . -name ".svn" -type d -exec rm -fr {} \;

cd -

exit 0
