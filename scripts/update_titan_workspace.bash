#!/bin/bash
#set -e
#set -xv

if [ ! -d /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop ]
then
    exit -1
fi
cd ~/tmp/workspace_titan/STF525_Auto_Interop/src

find . -name ".o" -type f -exec rm {} \;
rm ../bin/*

cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/etc .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/ccsrc/ .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/ttcn/ .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/asn1/ .
if [ -d ./bin/asn1 ]
then
    cp ~/TriesAndDelete/etsi_its/bin/asn1/* ./bin.asn1
fi
find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;

sudo find . -name ".svn" -type d -exec rm -fr {} \;

cd -

exit 0
