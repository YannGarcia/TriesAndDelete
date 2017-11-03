#!/bin/bash
#set -e
set -vx

function f_exit {
    cd ${CURPWD}
    
    unset TTCN_FILES
    unset CC_FILES
    unset CFG_FILES
    unset EXECUTABLE
    echo $1
    exit $2
}

function f_usage {
    echo "build.bash: This script import from External Disk the "
    echo "Optional arguments:"
    echo "  prof: Generate a makefile including profiling options (e.g. ./build.bash prof)"
    exit 0
}

clear

if [ "$1" == "help" ]
then
    f_usage
fi

ATS_NAME=GeoNetworking

#CURPWD=`pwd`
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
ASN1_PATH=${PATH_DEV_ITS}/asn1
if [ -d ${ASN1_PATH} ]
then
    ASN1_FILES=`find ${ASN1_PATH} -name '*.asn*'`

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

REFERENCES="LibCommon LibIts/Common LibIts/BTP LibIts/GeoNetworking LibIts/Ipv6OverGeoNetworking LibIts/Security LibIts/CAM LibIts/DENM"
for i in ${REFERENCES}
do
    # TTCN code
    for j in `find ${PATH_DEV_ITS}/src/$i/ttcn -type f -name "*.ttcn"`;
    do
	      ln -sf $j ../ttcn/`basename $j`
    done
    # Include source code
    files=`find ${PATH_DEV_ITS}/src/$i/include -type f`
    if [ "${files}" != " " ]
    then
	      for j in ${files};
	      do
	          ln -sf $j ../include/`basename $j`
	      done
    fi
    # CC source code
    files=`find ${PATH_DEV_ITS}/src/$i/src -type f`
    if [ "${files}" != " " ]
    then
	      for j in ${files};
	      do
	          ln -sf $j ../src/`basename $j`
	      done
    fi
done

# Generate the list of the TTCN-3 files
TTCN_FILES=`find .. -name '*.ttcn*'`

# Sart ATS generation - Step 1
if [ "${OSTYPE}" == "cygwin" ]
then
    rm ../bin/*.exe ../lib/*.dll
    compiler.exe -d -e -f -g -j -l -L -t -R -U none -x -X ${TTCN_FILES} ${ASN1_FILES} 2>&1 3>&1 | tee build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to compile ATS" 4
    fi
else
    compiler -d -e -f -g -l -L -t -R -U none -x -X ${TTCN_FILES} ${ASN1_FILES} 2>&1 3>&1 | tee build.log
    if [ "$?" == "1" ]
    then 
        f_exit "Failed to generate ATS source code" 6
    fi
fi

# Sart ATS generation - Step 2
# Create working variables
CC_FILES=`find ../src -name '*.c*'`
FWK_FILES=`find ${PATH_DEV_ITS}/framework/ -name '*.c*'`
CFG_FILES=`find ../etc -name '*.cfg'`

# Sart ATS generation - Step 3
if [ "${OSTYPE}" == "cygwin" ]
then
    ttcn3_makefilegen.exe -d -f -g -m -R -U none -e Ats${ATS_NAME} ${TTCN_FILES} ${ASN1_FILES} ${CC_FILES} ${FWK_FILES} ${CFG_FILES} | tee --append build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to compile ATS" 5
    fi
else
    ttcn3_makefilegen -d -f -g -m -R -U none -e Ats${ATS_NAME} ${TTCN_FILES} ${ASN1_FILES} ${CC_FILES} ${FWK_FILES} ${CFG_FILES} | tee --append build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to generate ATS source code" 7
    fi
fi

# Remove port skeletons to use src/<port skeletons>
for i in `ls ../include/*.hh`
do
    if [ -f ./`basename $i` ]
    then
	      rm ./`basename $i`
    fi
done
for i in `ls ../src/*.cc`
do
    if [ -f ./`basename $i` ]
    then
	      rm ./`basename $i`
    fi
done

# Check if Makefile was generated
if [ ! -f ./Makefile ]
then
    f_exit "Failed to generate ATS source code" 8
fi

# Patch ATS generated files
#./bin/patch.bash 2>&1 3>&1 | tee --append build.log
# Add compiler/linker options
# -DASN_DISABLE_OER_SUPPORT is required for CAMCodec and DENMCodec
if [ "$1" == "prof" ]
then
    CXXFLAGS_DEBUG_MODE='s/-Wall/-pg -Wall -std=c++11 -pthreads -fstack-check -fstack-protector/g' #  -DASN_DISABLE_OER_SUPPORT/g'
    LDFLAGS_DEBUG_MODE='s/LDFLAGS = /LDFLAGS = -pg -pthread -fstack-check -fstack-protector/g'
else
    CXXFLAGS_DEBUG_MODE='s/-Wall/-ggdb -O0 -Wall -std=c++11 -pthread -fstack-check -fstack-protector/g' #  -DASN_DISABLE_OER_SUPPORT/g'
    LDFLAGS_DEBUG_MODE='s/LDFLAGS = /LDFLAGS = -g -pthread -fstack-check -fstack-protector/g'
fi
ADD_INCLUDE='/CPPFLAGS = /a\\CPPFLAGS += -I/usr/local/share -I$(PATH_DEV_ITS)/include -I$(PATH_DEV_ITS)/include/asn1 -I$(PATH_DEV_ITS)/framework/include -I../include -I../../LibIts/Common/include -I../../LibIts/GeoNetworking/include -I$(HOME_INC) -I.'
ADD_LIBRARIES='s/LINUX_LIBS = -lxml2/LINUX_LIBS = -lrt -lxml2 -lpcap -L$(PATH_DEV_ITS)\/lib -lItsAsn /g'
sed --in-place "${CXXFLAGS_DEBUG_MODE}" ./Makefile 
sed --in-place "${LDFLAGS_DEBUG_MODE}" ./Makefile
sed --in-place "${ADD_INCLUDE}" ./Makefile
sed --in-place "${ADD_LIBRARIES}" ./Makefile
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
ADD_RUN_LINE_2='$a\\t@sudo LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) $(PWD)/../bin/$(EXECUTABLE) $(HOST) $(PORT)'
sed --in-place "${ADD_RUN_LINE_1}" ./Makefile 
sed --in-place "${ADD_RUN_LINE_2}" ./Makefile 
ADD_RUN_LINE_1='$arun_d: all'
ADD_RUN_LINE_2='$a\\t@gdb --args $(PWD)/../bin/$(EXECUTABLE) $(HOST) $(PORT)'
sed --in-place "${ADD_RUN_LINE_1}" ./Makefile 
sed --in-place "${ADD_RUN_LINE_2}" ./Makefile 
ADD_RUN_LINE_1='$arun_v: all'
ADD_RUN_LINE_2='$a\\t@sudo LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) valgrind -v --tool=memcheck --leak-check=yes --show-reachable=yes --track-fds=yes --run-cxx-freeres=yes $(PWD)/../bin/$(EXECUTABLE) $(HOST) $(PORT)'
sed --in-place "${ADD_RUN_LINE_1}" ./Makefile 
sed --in-place "${ADD_RUN_LINE_2}" ./Makefile 
# Add gendoc entry
ADD_RUN_LINE_1='$agendoc: ../docs/o2.cfg'
ADD_RUN_LINE_2='$a\\tdoxygen ../docs/o2.cfg'
sed --in-place "${ADD_RUN_LINE_1}" ./Makefile 
sed --in-place "${ADD_RUN_LINE_2}" ./Makefile 

# Build all
make all 2>&1 3>&1 | tee --append build.log
if [ "$?" == "1" ]
then
    f_exit "Failed to generate ATS source code" 9
fi
../bin/Ats${ATS_NAME} -v
f_exit "Build done successfully" 0
