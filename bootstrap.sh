#!/usr/bin/bash

# specify build directory
BUILD_PATH=build
# specify install directory. relative path starts at build directory
INSTALL_PATH=../install

# eg. debug or release
BUILD_TYPE=debug

# eg. g++, c++ or clang++
CXXCOMPILER=clang++

# source directory
SRC_DIR=$( cd $(dirname $0) && pwd )

# eg. make or Ninja
MAKE_TOOL=ninja


####################################################
if ! [[ "$1" ]]; then
    cat << EOF
$0 sets up a path-fault-debug build folder.
usage: $0 [OPTIONS] [build_dir]
  OPTIONS:
    --build           build project after cmake (default=build/)
    --clean           delete build folder before creating a new one
    --cmake <bin>     specify cmake executable
     -D<var>=<args>   pass option to cmake
    --install <dir>   configure cmake to install to this directory
     -i <dir>         (optional)
    --make_tool <arg> specify make tool like make or ninja
     -mt <arg>        (optional)
    --mode <type>     the CMake build type to configure, types are
     -m <type>        RELEASE, MINSIZEREL, RELWITHDEBINFO, DEBUG
      <build_dir>     the folder to setup the build environment in
EOF
    exit 1
fi

while [[ "$@" ]]; do
    case $1 in
        --build)      DO_MAKE="yes";;
        --clean|-c)   CLEAN="rm -rf";;
        --cmake)      CMAKE="$2"; shift;;
         -D*)         CMAKE_ARGS="$CMAKE_ARGS $1";;
        --install|-i) INSTALL_PATH="$2"; shift;;
        --make_tool|-mt) MAKE_TOOL=$2; shift;;
        --mode|-m)    BUILD_TYPE="$2"; shift;;
                *)  ## assume build dir
                      BUILD_PATH="$1";;
    esac
    shift;
done

if [[ "$CLEAN" ]]; then
  rm -rf $BUILD_PATH
fi

## use cmake generator
case $MAKE_TOOL in
  ninja)   CMAKE_TOOL="Ninja";;
   make)   CMAKE_TOOL="Unix Makefiles";;
esac

if [ ! -e lib/myBDD/.gitignore ]; then
  echo "git submodules not exist"
  git submodule init &&
  git submodule update
fi &&

mkdir -p $BUILD_PATH &&
cd $BUILD_PATH &&
CXX=$CXXCOMPILER cmake -DCMAKE_PREFIX_PATH=.. \
 -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH \
 -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
 "-G$CMAKE_TOOL" \
 $SRC_DIR &&

# compile
if [ -n "$DO_MAKE" ]; then
  $MAKE_TOOL
fi

cd -
