#!/bin/bash
#set -e
#set -xv

cd ~/tmp/workspace_titan/STF525_Auto_Interop/src
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/etc .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/ccsrc/ .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/ttcn/ .
cp -Rp /media/sf_F_DRIVE/FSCOM/ETSI/ITS/STF525_Auto_Interop/workspace_titan/STF525_Auto_Interop/src/asn1/ .

find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;

sudo find . -name ".svn" -type d -exec rm -fr {} \;

cd -

exit 0
