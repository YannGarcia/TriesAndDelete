#!/bin/bash
set -x

clear

function f_exit {
    cd ${CURPWD}
    
    unset TTCN_FILES
    unset CC_FILES
    unset CFG_FILES
    unset EXECUTABLE
    echo $1
    exit $2
}

CURPWD=`pwd`
if [ ! "${PWD##*/}" == "objs" ]
then
    cd ../objs
    if [ ! $? == 0 ]
    then
        echo "Please move to PROJECT/obj directory"
        exit 1
    fi
fi
# Remove everything
rm -fr ../objs/*.hh
rm -fr ../objs/*.cc
rm -fr ../objs/*.log
rm -fr ../objs/*.o
rm -fr ../objs/Makefile

# Remove useless files
find .. -type f -name "*~" -exec rm {} \;
find .. -type f -name "*.bak" -exec rm {} \;
find .. -type f -name "*.log" -exec rm {} \;

# Build XSD files if any and put them in objs directory
if [ -d ../xsd ]
then
    XSD_FILES=`find ../xsd -name '*.xsd'`

    if [ "${OSTYPE}" == "cygwin" ]
    then
        xsd2ttcn.exe ${XSD_FILES}
    else
        xsd2ttcn ${XSD_FILES}
    fi
    if [ "$?" != "0" ]
    then
        f_exit "Failed to generate XSD source code" 2
    fi
fi
# Build ASN.1 files if any and put them in objs directory
if [ -d ../asn.1 ]
then
    ASN1_FILES=`find ../asn.1 -name '*.asn*'`

    if [ "${OSTYPE}" == "cygwin" ]
    then
        asn1_compiler.exe ${ASN1_FILES}
    else
        asn1_compiler ${ASN1_FILES}
    fi
    if [ "$?" != "0" ]
    then
        f_exit "Failed to generate ASN.1 source code" 3
    fi
fi
# Create links for new generated ttcn files from XSD and/or ASN.1
for i in `find ../objs -type f -name "*.ttcn"`;
do
    ln -sf $i ../src/`basename $i`
done
# Add reference to the LibCommon
#for i in `find ../../LibCommon/src -type f -name "*.ttcn"`;
#do
#    ln -sf $i ../src/`basename $i`
#done

# Generate the list of the TTCN-3 files
TTCN_FILES=`find .. -name '*.ttcn*'`

# Sart ATS generation - Step 1
if [ "${OSTYPE}" == "cygwin" ]
then
    rm ../bin/*.exe ../lib/*.dll
    compiler.exe -b -d -f -g -l -L -t -R -U none -x -X -j ${TTCN_FILES} 2>&1 3>&1 | tee build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to compile ATS" 4
    fi
else
    compiler -b -d -f -g -l -L -t -R -U none -x -X -j ${TTCN_FILES} 2>&1 3>&1 | tee build.log
    if [ "$?" == "1" ]
    then 
        f_exit "Failed to generate ATS source code" 6
    fi
fi

# Sart ATS generation - Step 2
# Create working variables
CC_FILES=`find ../src -name '*.c*'`
CFG_FILES=`find ../etc -name '*.cfg'`

# Sart ATS generation - Step 3
if [ "${OSTYPE}" == "cygwin" ]
then
    ttcn3_makefilegen.exe -d -f -g -m -R -U none ${TTCN_FILES} ${CC_FILES} ${CFG_FILES} | tee --append build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to compile ATS" 5
    fi
else
    ttcn3_makefilegen -d -f -g -m -R -U none ${TTCN_FILES} ${CC_FILES} ${CFG_FILES} | tee --append build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to generate ATS source code" 7
    fi
fi

# Remove port skeletons to use src/<port skeletons>
for i in `ls ../include/*.hh`
do
    rm ./`basename $i`
done
for i in `ls ../src/*.cc`
do
    rm ./`basename $i`
done

# Patch ATS generated files
#./bin/patch.bash 2>&1 3>&1 | tee --append build.log
# Add compiler/linker options
if [ "$1" == "prof" ]
then
    CXXFLAGS_DEBUG_MODE='s/-Wall/-pg -Wall -std=c++11/g'
    LDFLAGS_DEBUG_MODE='s/LDFLAGS = /LDFLAGS = -pg /g'
else
    CXXFLAGS_DEBUG_MODE='s/-Wall/-g -Wall -std=c++11/g'
    LDFLAGS_DEBUG_MODE='s/LDFLAGS = /LDFLAGS = -g /g'
fi
ADD_INCLUDE='/CPPFLAGS = /a\\CPPFLAGS += -I../include -I$(HOME_INC) -I.'
sed --in-place "${CXXFLAGS_DEBUG_MODE}" ./Makefile 
sed --in-place "${LDFLAGS_DEBUG_MODE}" ./Makefile
sed --in-place "${ADD_INCLUDE}" ./Makefile
# Update clean clause
CLEAN_LINE='s/$(RM) $(EXECUTABLE)/$(RM) ..\/bin\/$(EXECUTABLE) ..\/src\/*.o/g'
sed --in-place "${CLEAN_LINE}" ./Makefile
# Move binary file command
EXECUTABLE=MyExample
MV_CMD='s/all: $(TARGET) ;/all: $(TARGET) ; @if [ -f ..\/objs\/$(EXECUTABLE) ]; then mv ..\/objs\/$(EXECUTABLE) ..\/bin; fi ;/g'
sed --in-place "${MV_CMD}" ./Makefile 
# Add run command
ADD_HOST='/PLATFORM = /aHOST=127.0.0.1'
ADD_PORT='/PLATFORM = /aPORT=12000'
sed --in-place "${ADD_PORT}" ./Makefile
sed --in-place "${ADD_HOST}" ./Makefile
ADD_RUN_LINE_1='$arun: all'
ADD_RUN_LINE_2='$a\\t@$(PWD)/../bin/$(EXECUTABLE) $(HOST) $(PORT)'
sed --in-place "${ADD_RUN_LINE_1}" ./Makefile 
sed --in-place "${ADD_RUN_LINE_2}" ./Makefile 
ADD_RUN_LINE_1='$arun_d: all_d'
ADD_RUN_LINE_2='$a\\t@gdb --args $(PWD)/../bin/$(EXECUTABLE) $(HOST) $(PORT)'
sed --in-place "${ADD_RUN_LINE_1}" ./Makefile 
sed --in-place "${ADD_RUN_LINE_2}" ./Makefile 

# Build all
make all 2>&1 3>&1 | tee --append build.log
if [ "$?" == "1" ]
then
    f_exit "Failed to generate ATS source code" 8
fi
f_exit "Build done successfully" 0
