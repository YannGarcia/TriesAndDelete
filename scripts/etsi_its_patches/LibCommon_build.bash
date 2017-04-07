#!/bin/bash
set -evx

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

# Create links for new generated ttcn files from XSD and/or ASN.1
for i in `find ../objs -type f -name "*.ttcn"`;
do
    ln -sf $i ../src/`basename $i`
done

# Generate the list of the TTCN-3 files
TTCN_FILES=`find .. -name '*.ttcn*'`

# Sart ATS generation - Step 1
if [ "${OSTYPE}" == "cygwin" ]
then
    rm ../bin/*.exe ../lib/*.dll
    compiler.exe -b -d -f -g -j -l -L -t -R -U none -x -X -j ${TTCN_FILES} 2>&1 3>&1 | tee build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to compile ATS" 4
    fi
else
    compiler -b -d -f -g -l -j -L -t -R -U none -x -X -j ${TTCN_FILES} 2>&1 3>&1 | tee build.log
    if [ "$?" == "1" ]
    then 
        f_exit "Failed to generate ATS source code" 6
    fi
fi

# Sart ATS generation - Step 2
# Create working variables
CC_FILES=`find ../src -name '*.c*'`
CFG_FILES=`find ../etc -name '*.cfg'`

EXECUTABLE=LibCommon

# Sart ATS generation - Step 3
if [ "${OSTYPE}" == "cygwin" ]
then
    ttcn3_makefilegen.exe -d -f -g -j -m -M -n -R -U none ${TTCN_FILES} ${CC_FILES} ${CFG_FILES} | tee --append build.log
    if [ "$?" == "1" ]
    then
        f_exit "Failed to compile ATS" 5
    fi
else
    ttcn3_makefilegen -d -f -g -l -L -m -M -n -R -U none -e ${EXECUTABLE} ${TTCN_FILES} ${CC_FILES} ${CFG_FILES} | tee --append build.log
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
CLEAN_LINE='s/$(RM) $(LIB_NAME)/$(RM) ..\/lib\/$(LIBRARY) ..\/src\/*.o/g'
sed --in-place "${CLEAN_LINE}" ./Makefile
# Move Library file command
MV_CMD='s/library: $(LIBRARY) ;/library: $(LIBRARY) ; @if [ -f ..\/objs\/$(LIBRARY) ]; then mv ..\/objs\/$(LIBRARY) ..\/lib; fi ;/g'
sed --in-place "${MV_CMD}" ./Makefile 

# Generate files
make compile 2>&1 3>&1 | tee --append build.log
if [ "$?" == "1" ]
then
    f_exit "Failed to generate source code" 8
fi

# Move include files
mv ./*.hh ../include

# Build library
make library 2>&1 3>&1 | tee --append build.log
if [ "$?" == "1" ]
then
    f_exit "Failed to build library" 9
fi

# Install include files & libraries
# TODO To be moved into Makefile in install section
PWD=`pwd`
for i in `ls ../include`
do
    if [ ! -L ~/include/`basename $i` ]
    then
	ln -s ${PWD}/../include/$i ~/include/`basename $i`
    fi
done

for i in `ls ../lib`
do
    if [ ! -L ~/lib/`basename $i` ]
    then
	ln -s ${PWD}/../lib/$i ~/lib/`basename $i`
    fi
done

f_exit "Build done successfully" 0
